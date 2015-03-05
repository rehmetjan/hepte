class User < ActiveRecord::Base
  include Gravtastic
  gravtastic secure: true, default: 'wavatar', rating: 'G', size: 48
  mount_uploader :avatar, AvatarUploader
  
  has_secure_password
  
  validates :username, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i }
  
  has_many :books
  
  def admin?
    CONFIG['admin_emails'] && CONFIG['admin_emails'].include(email)
  end
  
  def self.verifier_for(purpose)
    @verifiers ||= {}
    @verifiers.fetch(purpose) do |p|
      @verifiers[p] = Rails.application.message_verifier("#{self.name}-#{p.to_s}")
    end
  end
  
  def password_reset_token
    self.class.verifier_for('password-reset').generate([id, Time.now])
  end
  
  def self.find_by_password_reset_token(token)
    user_id, timestamp = verifier_for('password-reset').verify(token)
    User.find_by(id: user_id) if timestamps > 1.hour.ago
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
  
  def confirm
    update_attribute :confirmed, true
  end

  def confirmation_token
    self.class.verifier_for('confirmation').generate([id, email, Time.now])
  end

  def self.find_by_confirmation_token(token)
    user_id, email, timestamp = verifier_for('confirmation').verify(token)
    User.find_by(id: user_id, email: email) if timestamp > 1.hour.ago
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
  
end
