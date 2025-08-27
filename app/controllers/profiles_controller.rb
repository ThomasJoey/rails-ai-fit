class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update delete_avatar]

  def show
    @conversation = current_user.find_existing_conversation(@user)
    @conversation ||= Conversation.create(user: current_user, second_user: @user)
    
    @events = @user.events.order(starts_at: :asc)
  end

  def edit
    redirect_to profile_path(@user) if @user != current_user
  end

  def update
    redirect_to profile_path(@user) if @user != current_user

    if @user.update(user_params)
      redirect_to profile_path(@user), notice: "Profil mis à jour avec succès!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_avatar
    @user.avatar.purge
    redirect_to profile_path(@user), notice: "Avatar supprimé"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :bio, :avatar, :location, sports: [])
  end
end
