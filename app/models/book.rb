class Book < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  
  validates :name, presence: true
  validates :author, presence: true
  
  has_many :comments, as: 'commentable'
  has_many :likes, as: 'likeable'
  belongs_to :user
  
  after_create :update_hot
  after_touch :update_hot
  
  def total_pages
    (comments_count.to_f / Comment.default_per_page).ceil
  end
  
  def liked_by?(user)
    likes.where(user: user).exists?
  end
  
  def calculate_hot
    order = Math.log10([comments_count, 1].max)
    order + created_at.to_f / 45000
  end

  def update_hot
    # reload because comments_count has been cache in associations
    reload
    update_attribute :hot, calculate_hot
  end
  
end
