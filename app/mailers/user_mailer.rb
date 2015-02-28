class UserMailer < ActionMailer::Base
  
  def password_reset(user_id)
    @user = User.find(user_id)
    mail(to: @user.email),
         subject: 'password-reset')
  end
  
end
