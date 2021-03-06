class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :show]
  before_action :get_user, only: [:show, :edit, :update]
  before_filter :require_login, :only => [:edit, :update, :destroy]

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    current_user.assign_attributes(update_user_params)
    if current_user.save
      redirect_to "/users/#{current_user.username}"
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :root, notice: 'Tu proceso de registro esta casi completado, ve a tu badeja de entrada para completarlo'
    else
      flash[:error] = 'Tu proceso de registro no pudo ser completado'
      render :new
    end
  end

  def destroy
    current_user.destroy
    logout unless destroyed?
    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:avatar, :username, :email, :firstname, :lastname, :biography, :location, :password, :password_confirmation)
  end

  def get_user
    @user = User.find_by_username(params[:username])
  end
end
