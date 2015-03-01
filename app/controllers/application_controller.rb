class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :login?, :current_user
  
  def no_login_required
    if login?
      redirect_to root_url
    end
  end
  
  def login?
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    @current_user
  end
  
  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end
  
  def login_required
    unless login?
      redirect_to login_path(return_to: (request.fullpath if request.get?))
    end
  end
  
  def logout
    session.delete(:user_id)
    @current_user = nil
  end
  
end
