class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event has been created"
    else
      render :new, status: :unprocessable_entity
    end
  end

 def show
  message = Message.first
  chat = RubyLLM.chat

  system_prompt = <<~PROMPT
    You are a friendly sport events organizer whose goal is to help people meet others through sport events.
    List three sport event proposals. For each event, provide:
    - Title
    - Description
    - Start date
    - End date
    - Location
    Output exactly three proposals in French, then a JSON array "events" with those five keys.
  PROMPT

  chat.with_instructions(system_prompt)

  user_prompt = "J'aimerais faire du sport jeudi. #{message&.content}"
  response = chat.ask(user_prompt)

  # Option A : afficher brut
  render plain: response.content

  # Option B : si tu préfères une vue
  # @llm_text = response.content
  # render :show
  end



  private

  def event_params
    params.require(:event).permit(:title)
  end
end
