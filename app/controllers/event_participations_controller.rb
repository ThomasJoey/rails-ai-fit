class EventParticipationsController < ApplicationController
  def new
    @event_participation = EventParticipations.new
  end

  def create
    @event_participation = EventParticipations.new(event_participations)
    if @event_participation.save
      redirect_to @event_participation, notice: "Event has been created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_participations_params
    params.require(:event_participation).permit(:user_id, :event_id)
  end
end
