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
end
