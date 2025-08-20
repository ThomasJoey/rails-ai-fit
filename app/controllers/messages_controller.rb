# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(message_params)
    @message.role = "user"

    if @message.save
      chat = RubyLLM.chat
      context = Message::SYSTEM_PROMPT
      chat.with_instructions(context)
      response = chat.ask(@message.content)
      assistant_response = response.content

      Message.create!(
        content: assistant_response,
        role: "assistant",
        conversation: @conversation
      )

      redirect_to conversation_path(@conversation), notice: "Message envoyé ✅"
    else
      @messages = @conversation.messages.order(:created_at)
      render "conversations/show", status: :unprocessable_entity
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
