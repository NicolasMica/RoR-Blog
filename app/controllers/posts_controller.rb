class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  # Authorized params
  def authorized_attributes
    params.require(:post).permit(
        :name,
        :heading,
        :content,
        :image
    )
  end

  # Checks if the logged user has rights on the given post
  def authorized_user? post
    post.user_id == current_user.id
  end

  # Redirects the user if authorization failed
  def check_authorization post
    unless authorized_user?(post)
      redirect_to post, notice: "Vous n'avez pas les droits nécessaires sur cet article."
    end
  end

  # Ordered & paginated list of the post resource
  def index
    @posts = Post.includes(:user)
                 .order('posts.created_at DESC')
                 .page(params[:page])
                 .per(6)
  end

  # Show a specific post resource
  # Eager loading auhtor user, comments & comments' user
  def show
    @post = Post.includes(:user, comments: :user)
                .order("comments.created_at DESC")
                .find(params[:id])

    @comment = Comment.new
  end

  # Show the form to create a new post resource
  def new
    @post = Post.new
  end

  # Perform the storage of the post resource
  def create
    @post = Post.new(authorized_attributes)
    @post.user = current_user

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  # Show the form to edit a post resource
  def edit
    @post = Post.find(params[:id])

    check_authorization(@post)
  end

  # Perform the update of the post resource
  def update
    @post = Post.find(params[:id])

    check_authorization(@post)

    if @post.update_attributes(authorized_attributes)
      redirect_to @post
    else
      render 'edit'
    end
  end

  # Delete the given post resource
  def destroy
    @post = Post.find(params[:id])

    check_authorization(@post)

    @post.destroy

    redirect_to :action => 'index'
  end
end
