class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def index
    @events = Event.order(:start_time)
    @stats = {
      steps: { current: 8247, goal: 10000 },
      calories: { current: 342, goal: 500 },
      sessions: { current: 135, goal: 180 }, # en minutes
      distance: { current: 5.8, goal: 10 }
    }
  end

  def search
    query = params[:query]
    @events = Event.where("title ILIKE ?", "%#{query}%")
    render partial: "events_list", locals: { events: @events }
  end
end
