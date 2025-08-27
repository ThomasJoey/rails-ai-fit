class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to posts_path }
      end
    else
      redirect_to posts_path, alert: "Erreur lors du like"
    end
  end

  def destroy
    @like = @post.likes.find(params[:id])
    @like.destroy if @like.user == current_user
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
