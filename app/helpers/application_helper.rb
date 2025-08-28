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

  # app/helpers/application_helper.rb
  def user_initials(user)
    return "U" unless user

    first = user.first_name&.first
    last = user.last_name&.first

    initials = "#{first}#{last}".upcase
    initials.present? ? initials : "U"
  end

  def other_participant(conversation, current_user)
    conversation.participants.reject { |u| u == current_user }.first
  end
end
