class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[age sexe])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[age sexe])
  end

  private

  def user_intent
    user_messages = @conversation.messages.select { |message| message.role == "user" }
    user_messages.any? do |message|
      message.content.downcase.match?(/\b(faire|organiser|prévoir|aller|participe|lance|prévois|viens|jouer|joues?|cours?|nager|nages?|bouger|bouges?)\b.*\b(run|course|match|séance|entraînement|sortie|event|évènement|foot|volley|vélo|natation|basket|sport)\b/)
    end
  end
end
