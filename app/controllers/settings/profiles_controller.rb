class Settings::ProfilesController < Settings::ApplicationController
  def show
  end
  
  def update
    if @user.update_attributes params.require(:user).permit(:name, :bio, :avatar, :remove_avatar)
      flash[:success] = 'successfully updated'
      redirect_to settings_profile_path
    else
      render :show
    end
  end
end
