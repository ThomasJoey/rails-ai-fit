class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create_events
    @conversation = Conversation.find(params[:id])

    # Rejouer un prompt spécifique pour demander les events
    ruby_llm_chat = RubyLLM.chat
    build_conversation_history
    ruby_llm_chat.with_instructions("À partir de cette conversation, génère 3 events en JSON { events: [...], proposals: '...' }")

    response = ruby_llm_chat.ask("Propose-moi 3 événements")
    json_response = JSON.parse(response.content)

    events_data = json_response["events"]
    proposals   = json_response["proposals"]

    assistant_message = @conversation.messages.create!(
      content: proposals,
      role: "assistant",
      conversation: @conversation
    )

    events_data.each do |event_attributes|
      event = Event.new(event_attributes)
      event.message = assistant_message
      event.save
    end

    redirect_to @conversation, notice: "3 événements générés ✅"
  end





  # def create

  #   json_response = @assistant_response

  #   @events = JSON.parse(json_response)
  #   @event = Event.new(event_params)
  #   if @event.save
  #     redirect_to conversations_path
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # def show
  # message = Message.first
  # chat = RubyLLM.chat

  # system_prompt = <<~PROMPT
  #   You are a friendly sport events organizer whose goal is to help people meet others through sport events.
  #   For each event, provide :
  #   - Title
  #   - Description
  #   - Starts_at
  #   - Ends_at
  #   - Location
  #   Output exactly three proposals in French on the JSON array name "events" with those five keys.
  # PROMPT


  # chat.with_instructions(system_prompt)

  # user_prompt = "J'aimerais faire du sport jeudi. #{message&.content}"
  # response = chat.ask(user_prompt)

  # # Option A : afficher brut
  # render plain: response.content

  # # Option B : si tu préfères une vue
  # # @llm_text = response.content
  # # render :show
  # end

  def show
    # conversation_message_path	GET	/conversations/:conversation_id/messages/:id(.:format)
    json_response = @assistant_response
    @events = JSON.parse(json_response)

    # @events = Event.all.as_json(only: [:title, :description, :starts_at, :ends_at, :location])

  end

  private

  def event_params
    params.require(:event).permit(:title)
  end
end
