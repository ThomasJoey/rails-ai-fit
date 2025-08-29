class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show destroy create_events]

  def index
    @conversations = Conversation.all.order(created_at: :desc)
  end

  def show
    @conversations = Conversation.all.order(created_at: :desc)

    if @conversation.ai_chat?
      @message = Message.new
    else
      @message_user = MessageUser.new
    end
  end

  def new
    @users = User.all
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(
      title: "Nouvelle conversation",
      context: "",
      user: current_user
    )
    @conversation.second_user = User.find(params[:second_user_id]) if params[:second_user_id]

    if @conversation.save
      # Add automatic first message for AI chats
      if @conversation.ai_chat? && @conversation.messages.none?
        @conversation.messages.create!(
          content: "Salut ! Je suis ton coach d’événements sportifs. Dis‑moi ce que tu veux faire, ta ville et tes dispos, et je te propose une idée ✨",
          role: "assistant"
        )
      end
      redirect_to conversation_path(@conversation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @conversation.destroy
    if Conversation.exists?
      redirect_to Conversation.order(created_at: :desc).first, notice: "Conversation supprimée ✅"
    else
      # 👉 On recrée une conversation vide si tout est supprimé
      new_conv = Conversation.create!(
        title: "Nouvelle conversation",
        context: "",
        user: current_user
      )
      redirect_to new_conv, notice: "Conversation supprimée. Nouvelle conversation créée ✅"
    end
  end

  # 🚀 Génération des 3 events
  def create_events
    @ruby_llm_chat = RubyLLM.chat
    build_conversation_history
    @ruby_llm_chat.with_instructions(Message::SYSTEM_PROMPT)

    response = @ruby_llm_chat.ask("Propose-moi 1 événement")

    begin
      json_response = JSON.parse(response.content)

      events_data = json_response["events"] || []
      proposals   = json_response["proposals"] || []

      # 🔹 Message assistant avec les propositions lisibles
      assistant_message = @conversation.messages.create!(
        content: proposals.is_a?(Array) ? proposals.map { |p| p["text"] }.join("\n\n") : proposals.to_s,
        role: "assistant",
        conversation: @conversation
      )

      # 🔹 Création des events liés à l'utilisateur (plus de message_id)
      events_data.each do |event_attributes|
        Event.create!(event_attributes.merge(user: current_user))
      end

      redirect_to @conversation, notice: "1 événement générés ✅"
    rescue JSON::ParserError
      # Si le LLM ne renvoie pas de JSON valide
      @conversation.messages.create!(
        content: response.content,
        role: "assistant",
        conversation: @conversation
      )

      redirect_to @conversation, alert: "⚠️ L'IA n'a pas renvoyé un JSON valide. Réponse affichée telle quelle."
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def build_conversation_history
    @conversation.messages.order(:created_at).each do |msg|
      @ruby_llm_chat.add_message(role: msg.role, content: msg.content)
    end
  end
end
