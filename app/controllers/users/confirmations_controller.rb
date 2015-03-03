class Users::ConfirmationsController < ApplicationController
  before_action :login_required, :no_confirmed_required
  
  def show
    if params[:token].present?
      @user = User.find_by_confirmation_token(params[:token])
      if @user && @user == current_user
        @user.confirm
        flash[:success] = I18n.t('users.confirmations.confirm_success')
        redirect_to root_url
      end
    end
  end

  def create
    UserMailer.confirmation(current_user.id).deliver
  end

  private

  def no_confirmed_required
    if current_user.confirmed?
      redirect_to root_url
    end
  end
  
end
