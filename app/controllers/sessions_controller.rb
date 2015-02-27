class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find login_params
    if @user && @user.authenticate(login_params[:password])
      redirect_to root_url
    else
      flash.now[:warning] = 'incorrect password or email'
    end
  end
  
  private
  
  def login_params
    params.require(:user).permit(:email, :password)
  end
end
