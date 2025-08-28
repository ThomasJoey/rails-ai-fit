class EventsController < ApplicationController
  before_action :set_event, only: [:destroy]

  def new
    @event = Event.new
  end

  def create
    @participation = @event.event_participations.new(user: current_user)

    if @participation.save
      redirect_to events_path, notice: "🎉 Tu es inscrit à l'événement '#{@event.title}'"
    else
      redirect_to events_path, alert: "⚠️ Impossible de t'inscrire à cet événement."
    end
  end

  def create_events
    @conversation = Conversation.find(params[:id])

    # Rejouer un prompt spécifique pour demander les events
    ruby_llm_chat = RubyLLM.chat
    build_conversation_history
    ruby_llm_chat.with_instructions("À partir de cette conversation, génère 1 event en JSON { events: [...], proposals: '...' }")

    response = ruby_llm_chat.ask("Propose-moi 1 événement")
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

  def show
    # conversation_message_path	GET	/conversations/:conversation_id/messages/:id(.:format)
    json_response = @assistant_response
    @events = JSON.parse(json_response)

    # @events = Event.all.as_json(only: [:title, :description, :starts_at, :ends_at, :location])
  end

  def index
    @events = Event.all.order(starts_at: :asc)

    if params[:query].present?
      @events = @events.where("title ILIKE :q OR description ILIKE :q OR location ILIKE :q", q: "%#{params[:query]}%")
    end

    return unless params[:date].present?

    date = begin
      Date.parse(params[:date])
    rescue StandardError
      nil
    end
    return unless date

    @events = @events.where("DATE(starts_at) = ?", date)
  end

  def destroy
    if @event.present?
      @event.destroy
      redirect_to events_path, notice: "Événement supprimé ✅"
    else
      redirect_to events_path, alert: "⚠️ Impossible de trouver cet événement."
    end
  end

  def search
    query = params[:query]
    @events = Event.where("title ILIKE ?", "%#{query}%")
    render partial: "dashboards/events_today", locals: { events: @events }
  end

  private

  def event_params
    params.require(:event).permit(:title)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
