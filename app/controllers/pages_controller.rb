class PagesController < ApplicationController
  before_action :authenticate_user!
  
  def home
  end

  def search
    @users = User.all

    return unless params[:query].present?

    @users = User.where("first_name ILIKE :q OR last_name ILIKE :q", q: "%#{params[:query]}%")

    return unless turbo_frame_request?

    render partial: "pages/search_results", locals: { users: @users }
  end
end
