class EventParticipationsController < ApplicationController
  before_action :set_event, only: :create
  before_action :set_event_participation, only: :destroy

  def create
    @participation = current_user.event_participations.create!(event: @event)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to profile_path, notice: "Vous êtes inscrit 🎉" }
    end
  end

  def destroy
    @event = @event_participation.event
    @event_participation.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to profile_path, notice: "Désinscription réussie", status: :see_other }
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_event_participation
    @event_participation = current_user.event_participations.find(params[:id])
  end
end
