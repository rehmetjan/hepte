class Book < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  
  validates :name, presence: true
  validates :author, presence: true
  
  has_many :comments, as: 'commentable'
  has_many :likes, as: 'likeable'
  belongs_to :user
  
  def total_pages
    (comments_count.to_f / Comment.default_per_page).ceil
  end
  
  def liked_by?(user)
    likes.where(user: user).exists?
  end
  
end
