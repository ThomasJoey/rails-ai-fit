class PagesController < ApplicationController
  def home
  end

  def search
    @users = User.all
    return unless params[:query].present?

    @users = User.where("first_name ILIKE :q OR last_name ILIKE :q", q: "%#{params[:query]}%")
  end
end
