class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(:created_at)
    @message = @conversation.messages.new
  end

  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.user = current_user

    if @conversation.save
      redirect_to conversations_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:title, :context)
  end
end
