class User < ActiveRecord::Base
  has_secure_password
  
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i }

end
