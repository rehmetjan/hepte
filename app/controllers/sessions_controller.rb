class SessionsController < ApplicationController
  before_action :no_login_required, only: [:new, :create]
  
  def new
  end
  
  def create
    login = login_params[:login]
    @user = if login.include?('@')
              User.where('lower(email) = lower(?)', login).first
            else
              User.where('lower(username) = lower(?)', login).first
            end
            
    if @user && @user.authenticate(login_params[:password])
      login_as @user
      redirect_to root_url
    else
      flash.now[:warning] = 'incorrect username or password'
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url
  end
  
  private
  
  def login_params
    params.require(:user).permit(:login, :password)
  end
end
