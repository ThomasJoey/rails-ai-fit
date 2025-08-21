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

      json_response = JSON.parse(assistant_response)
      events_data = json_response["events"]
      @proposals = json_response["proposals"]

      assistant_message = Message.create!(
        content: @proposals, # TODO
        role: "assistant",
        conversation: @conversation
      )

      events_data.each do |event_attributes|
        event = Event.new(event_attributes)
        event.message = assistant_message
        event.save
      end

      redirect_to conversation_path(@conversation), notice: "Message envoyé ✅"
    else
      @messages = @conversation.messages.order(:created_at)
      render "conversations/show", status: :unprocessable_entity
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

  def event_params
    params.require(:event).permit(:title)
  end
end
