class User < ActiveRecord::Base
  has_secure_password
  
  validates :username, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i }
  
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
  
end
