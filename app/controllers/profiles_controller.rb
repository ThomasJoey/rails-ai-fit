class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @events = @user.events.order(starts_at: :asc)
  end
end
