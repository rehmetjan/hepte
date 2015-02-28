class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email login_params[:email]
    if @user && @user.authenticate(login_params[:password])
      login_as @user
      redirect_to root_url
    else
      flash.now[:warning] = "incorrect password or email"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url
  end
  
  private
  
  def login_params
    params.require(:session).permit(:email, :password)
  end
end
