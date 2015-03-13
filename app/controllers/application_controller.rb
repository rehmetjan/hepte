class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :login?, :current_user
  
  before_action :set_locale
  
  private
  class AccessDenied < Exception; end
  
  def no_login_required
    if login?
      redirect_to root_url
    end
  end
  
  def email_confirmed_required
    if !current_user.confirmed?
      redirect_to new_users_confirmation_path(return_to: (request.fullpath if request.get?))
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
  
  def no_locked_required
    if login? and current_user.locked?
      raise AccessDenied
    end
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
  
  def set_locale
    I18n.locale = current_user.try(:locale) || I18n.default_locale || http_accept_language.compatible_language_from(I18n.available_locales)
  end
  
end
