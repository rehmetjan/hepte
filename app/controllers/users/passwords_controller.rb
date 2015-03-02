class Users::PasswordsController < ApplicationController
  before_action :no_login_required
  before_action :check_token, only: [:edit, :update]
  
  def new
  end
  
  def create
    if @user = User.where('lower(email) = lower(?)', params[:email]).first
      UserMailer.password_reset(@user.id).deliver
      redirect_to users_password_path
    else
      flash.now[:warning] = 'email not found'
      redirect_to root_url
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes params.require(:user).permit(:password, :password_confirmation)
      flash[:success] = 'password successfully updated'
      redirect_to login_url
    else
      render :edit
    end
  end
  
  private 
  
  def check_token
    unless @user = User.find_by_password_reset_token(params[:token])
      flash[:warning] = 'token invalid'
      redirect_to new_users_password_path
    end
  end
  
end
