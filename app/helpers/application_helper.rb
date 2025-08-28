module ApplicationHelper
  def body_class_for_page
    classes = []

    if devise_controller?
      classes << "devise-controller"
      classes << "devise-#{controller_name}"
      classes << "devise-#{controller_name}-#{action_name}"
    else
      classes << "main-app"
      classes << "#{controller_name}"
      classes << "#{controller_name}-#{action_name}"
    end

    classes.join(' ')
  end

  def main_content_class
    if devise_controller?
      "devise-content"
    else
      "main-content"
    end
  end

  # Données de stats pour le dashboard, disponibles partout (layout)
  def dashboard_stats
    {
      steps:    { label: "Nombre de pas",   current: 8247, goal: 10_000, icon: "fa-shoe-prints" },
      calories: { label: "Calories",         current: 342,  goal: 500,    icon: "fa-fire" },
      sessions: { label: "Heures/séances",   current: 135,  goal: 180,    icon: "fa-clock" }, # minutes
      distance: { label: "Distance",         current: 5.8,  goal: 10.0,   icon: "fa-location-dot" }
    }
  end

  def stat_percentage(current, goal)
    return 0 if goal.to_f <= 0
    percent = (current.to_f / goal.to_f) * 100.0
    percent.clamp(0, 100).round
  end
end
