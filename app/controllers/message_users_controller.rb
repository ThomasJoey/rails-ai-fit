class MessageUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def create
    unless @conversation.participant?(current_user)
      redirect_to conversation_path(@conversation), alert: "Tu ne participes pas à cette conversation."
      return
    end

    @message_user = @conversation.message_users.build(message_user_params)
    @message_user.sender = current_user
    
    if @message_user.save
      redirect_to conversation_path(@conversation), notice: "Message envoyé."
    else
      render "conversations/show", status: :unprocessable_entity
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_user_params
    params.require(:message_user).permit(:content)
  end
end
