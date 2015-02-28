class UsersController < ApplicationController
  
  def index
    @users = User.order(id: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new params.require(:user).permit(:name, :email, :password)
    if @user.save
      redirect_to root_url
    else
      render 'new'
    end
  end
end
