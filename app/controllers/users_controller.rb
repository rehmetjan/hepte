class UsersController < ApplicationController
  
  def index
    @users = User.order(id: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new params.require(:user).permit(:name, :username, :email, :password)
    if @user.save
      login_as @user
      UserMailer.password_reset(@user.id).deliver
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def check_email
    respond_to do |format|
      format.json do
        render json: !User.where('lower(email) = ?', params[:user][:email].downcase).where.not(id: params[:id]).exists?
      end
    end
  end

  def check_username
    respond_to do |format|
      format.json do
        render json: !User.where('lower(username) = ?',  params[:user][:username].downcase).where.not(id: params[:id]).exists?
      end
    end
  end
  
end
