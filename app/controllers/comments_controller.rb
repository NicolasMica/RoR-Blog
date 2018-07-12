class CommentsController < ApplicationController

  before_action :authenticate_user!

  # Authorized params
  def authorized_attributes
    params.require(:comment).permit(:content)
  end

  # Checks if the logged user has rights on the given comment
  def authorized_user? comment
    comment.user_id == current_user.id || comment.post.user_id == current_user.id
  end

  # Create a comment resource
  def create
    @comment = Comment.new(authorized_attributes)
    @comment.post = Post.find params[:post_id]
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.post, notice: 'Commentaire sauvegardé avec succès !'
    else
      redirect_to @comment.post, notice: 'Une erreur s\'est produite.'
    end
  end

  # Destroy a comment resource
  def destroy
    @comment = Comment.includes(:user, :post).find(params[:id])

    if authorized_user?(@comment)
      @comment.destroy
    end

    redirect_to @comment.post
  end
end
