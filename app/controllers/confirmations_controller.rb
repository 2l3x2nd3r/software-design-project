class ConfirmationsController < ApplicationController
  skip_before_action :require_login

  def show
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to :root, notice: 'your account has been activated'
    else 
      redirect_to :root, error: 'Invalid Token'
    end
  end
end