class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def index
    # Données factices pour l’exemple
    @weather = { city: "Paris", temp: 18, label: "Parfait pour courir" }
    @stats = { matches: 3, messages: 12, events: 5 }

    @users_nearby = [
      { name: "Emma", age: 26, sport: "Running", distance: 0.8, match: 92, avatar: "emma.jpg" },
      { name: "Lucas", age: 29, sport: "CrossFit", distance: 1.2, match: 88, avatar: "lucas.jpg" },
      { name: "Sofia", age: 24, sport: "Yoga", distance: 2.1, match: 75, avatar: "sofia.jpg" }
    ]

    @recent_matches = [
      { name: "Alex", sport: "Cyclisme", last_seen: "il y a 2h", avatar: "alex.jpg", unread: true },
      { name: "Emma", sport: "Running", last_seen: "hier", avatar: "emma.jpg", unread: false }
    ]

    @events_today = [
      { title: "Course matinale au Bois", time: "07:30", place: "Bois de Vincennes", participants: "8/12", joinable: true },
      { title: "Session CrossFit", time: "18:00", place: "FitClub Central", participants: nil, joinable: false }
    ]
  end

  def search
    query = params[:query]
    @events = Event.where("title ILIKE ?", "%#{query}%")
    render partial: "dashboards/events_list", locals: { events: @events }
  end
end
