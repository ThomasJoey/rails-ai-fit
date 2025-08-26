# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(message_params)
    @message.role = "user"
    @message.user = current_user

    if @message.save
      # Génère un titre si c’est le premier message
      if @conversation.messages.where(role: "user").count == 1
        @conversation.generate_title_from_first_message
      end

      # Prépare le chat avec l’IA
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
      @ruby_llm_chat.with_instructions(Message::SYSTEM_PROMPT_COACH)

      # Envoie le message de l’utilisateur
      response = @ruby_llm_chat.ask(@message.content)
      assistant_response = response.content

      # 🔹 On essaye de parser en JSON (si l’IA a renvoyé du JSON)
      begin
        json_response = JSON.parse(assistant_response)
        proposals = json_response["proposals"]

        # On stocke seulement le texte des propositions
        readable_text =
          if proposals.is_a?(Array)
            proposals.map { |p| p["text"] }.join("\n\n")
          else
            proposals.to_s
          end

        @conversation.messages.create!(
          content: readable_text,
          role: "assistant",
          conversation: @conversation
        )

      rescue JSON::ParserError
        # 🔹 Sinon, on garde tel quel (texte libre)
        @conversation.messages.create!(
          content: assistant_response,
          role: "assistant",
          conversation: @conversation,
          user: current_user
        )
      end

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to conversation_path(@conversation), notice: "Message envoyé ✅" }
      end

    else
      @messages = @conversation.messages.order(:created_at)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_message",
            partial: "messages/form",
            locals: { conversation: @conversation, message: @message }
          )
        end
        format.html { render "conversations/show", status: :unprocessable_entity }
      end
    end
  end


  private


  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
    # conversation_message_path	GET	/conversations/:conversation_id/messages/:id(.:format)
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def build_conversation_history
    @conversation.messages.each do |message|
      @ruby_llm_chat.add_message(RubyLLM::Message.new(message.attributes.symbolize_keys))
    end
  end

  def event_params
    params.require(:event).permit(:title)
  end
end
