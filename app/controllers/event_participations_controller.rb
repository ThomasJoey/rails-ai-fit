class EventParticipationsController < ApplicationController
  before_action :set_event

  def create
    participation = @event.event_participations.new(user: current_user)
    if participation.save
      redirect_to events_path, notice: "🎉 Tu es inscrit à '#{@event.title}'"
    else
      redirect_to events_path, alert: "⚠️ Impossible de t'inscrire."
    end
  end

  def destroy
    participation = @event.event_participations.find(params[:id])
    participation.destroy
    redirect_to events_path, notice: "🚫 Tu es désinscrit de '#{@event.title}'"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
