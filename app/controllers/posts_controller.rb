class PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = Post.includes(:user, :comments, :likes).order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post créé avec succès ✅"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "Post supprimé 🗑️"
    else
      redirect_to posts_path, alert: "Tu n’es pas autorisé à supprimer ce post ❌"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content_text, :image)
  end
end
