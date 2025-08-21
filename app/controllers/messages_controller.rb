# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(message_params)
    @message.role = "user"

    if @message.save
      if @conversation.messages.where(role: "user").count == 1
        @conversation.generate_title_from_first_message
      end
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
      context = Message::SYSTEM_PROMPT
      @ruby_llm_chat.with_instructions(context)
      response = @ruby_llm_chat.ask(@message.content)
      assistant_response = response.content

      @conversation.messages.create!(
        content: assistant_response,
        role: "assistant",
        conversation: @conversation
      )
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to conversation_path(@conversation), notice: "Message envoyé ✅" }
      end

    else
      @messages = @conversation.messages.order(:created_at)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form",
                                                                   locals: { conversation: @conversation, message: @message })
        end
        format.html { render "conversations/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def build_conversation_history
    @conversation.messages.each do |message|
      @ruby_llm_chat.add_message(RubyLLM::Message.new(message.attributes.symbolize_keys))
    end
  end
end
