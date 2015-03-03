class UserMailer < ActionMailer::Base
  
  def password_reset(user_id)
    @user = User.find(user_id)
    mail(to: @user.email,
         subject: I18n.t('user_mailer.password_reset.subject'))
  end
  
  def confirmation(user_id)
    @user = User.find(user_id)
    mail(to: @user.email,
         subject: I18n.t('user_mailer.confirmation.subject'))
  end
  
end
