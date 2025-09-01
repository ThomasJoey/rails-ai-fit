class OnboardingController < ApplicationController
  include Wicked::Wizard

  steps :age, :sports, :bio

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to next_wizard_path
  end

  private

  def user_params
    case step
    when :age
      params.require(:user).permit(:age_range)
    when :sports
      params.require(:user).permit(sports: [])
    when :bio
      params.require(:user).permit(:bio)
    else
      {}
    end
  end
end
