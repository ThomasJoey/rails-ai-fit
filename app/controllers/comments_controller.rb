class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to posts_path, notice: "Commentaire ajouté 💬"
    else
      redirect_to posts_path, alert: "Erreur lors de l’ajout du commentaire"
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to posts_path, notice: "Commentaire supprimé"
    else
      redirect_to posts_path, alert: "Non autorisé ❌"
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content_text)
  end
end
