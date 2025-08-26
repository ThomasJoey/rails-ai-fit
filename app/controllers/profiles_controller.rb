class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
     @events = @user.events.order(starts_at: :asc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_avatar
    current_user.avatar.purge
    redirect_to profile_path, notice: "Avatar supprimé"
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :bio, sports: [])
  end
end


# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profil mis à jour avec succès!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :bio, :avatar, :location, sports: [])
  end

  def create
    
  end
end
