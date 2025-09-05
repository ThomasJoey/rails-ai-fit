class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[show destroy create_events]

  def index
    @conversations = Conversation.where(user: current_user)
                                 .or(Conversation.where(second_user: current_user))
  end

  def show
    @conversations = Conversation.all.order(created_at: :desc)
    @sport_will = user_intent
    @other_user = (@conversation.participants - [current_user]).first
    if @conversation.ai_chat?
      @message = Message.new
    else
      @message_user = MessageUser.new
    end
  end

  def new
    @users = current_user.accepted_users
    @conversation = Conversation.new
  end

  def search

    id = current_user.id

    matched_ids  = Match.where(matcher_id: id).select(:matched_id) # ceux que j’ai matchés
    matcher_ids  = Match.where(matched_id: id).select(:matcher_id) # ceux qui m’ont matché

    return unless params[:query].present?

    @users = User.where(id: matched_ids)
                 .or(User.where(id: matcher_ids)) # <- méthode AR, pas l’opérateur Ruby
                 .where.not(id: id) # par sécurité, ne me renvoie pas moi-même
                 .distinct
                 .where("first_name ILIKE :q OR last_name ILIKE :q", q: "%#{params[:query]}%")

    @users = @users.empty? ? current_user.accepted_users : @users

    return unless turbo_frame_request?

    render partial: "conversations/search_results", locals: { users: @users }
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
    redirect_to conversations_path, notice: "Conversation supprimée ✅"
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
      @conversation.messages.create!(
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

  def event_button
    @conversation = Conversation.find(params[:id])
    @last_user_message = @conversation.messages.where(role: "user").order(:created_at).last

    render partial: "conversations/event_button", locals: {
      conversation: @conversation,
      last_user_message: @last_user_message
    }
  end


  def create_with_user
    other_user = User.find(params[:user_id])

    conversation = Conversation.between(current_user, other_user).first

    unless conversation
      conversation = Conversation.create!(
        user: current_user,
        second_user: other_user,
        title: "Nouvelle conversation",
        context: ""
      )
    end

    redirect_to conversation_path(conversation)
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
