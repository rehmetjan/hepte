class Book < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  
  validates :name, presence: true, format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  validates :author, presence: true, format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  
  has_many :comments, as: 'commentable'
  belongs_to :user
  
  def total_pages
    (comments_count.to_f / Comment.default_per_page).ceil
  end
  
end
