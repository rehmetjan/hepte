class Book < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  
  validates :name, presence: true, format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  validates :author, presence: true, format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  
end
