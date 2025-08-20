# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(message_params)

    if @message.save

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
