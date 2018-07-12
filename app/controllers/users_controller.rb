class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Checks if the logged user has rights on the given user
  def authorized_user? user
    user.id == current_user.id
  end

  def check_authorization user
    unless authorized_user? user
      redirect_to user, notice: "Vous n'avez pas les droits nécessaires sur cet utilisateur."
    end
  end

  # Show a specific user resource
  # Eager loading posts & comments
  def show
    @user = User.includes(:posts, :comments)
                .order('posts.created_at ASC, comments.created_at DESC')
                .find(params[:id])
  end

  # Show the form to edit a user resource
  def edit
    @user = User.find(params[:id])

    check_authorization(@user)
  end

  # Perform the update of the user resource
  def update
    @user = User.find(params[:id])

    check_authorization(@user)

    if @user.update(user_params)
      redirect_to @user, notice: "Modifications sauvegardées avec succès !"
    else
      render 'edit', alert: "Une erreur s'est produite."

    end
  end

  # Delete the given user resource
  def destroy
    @user = User.find(params[:id])

    check_authorization(@user)

    @user.destroy
    session[:user_id] = nil

    redirect_to :controller => 'posts', :action => 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
