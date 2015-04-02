class Book < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  mount_uploader :picture, PictureUploader
  
  validates :name, presence: true
  validates :author, presence: true
  
  has_many :comments, as: 'commentable'
  has_many :likes, as: 'likeable'
  belongs_to :user
  belongs_to :category, counter_cache: true
  
  after_create :update_hot
  after_touch :update_hot
  
  scope :unlocked, -> { where(locked: false) }
  scope :locked, -> { where(locked: true) }
  
  def total_pages
    (comments_count.to_f / Comment.default_per_page).ceil
  end
  
  def liked_by?(user)
    likes.where(user: user).exists?
  end
  
  def lock
    update_attribute :locked, true
  end
  
  def unlock
    update_attribute :locked, false
  end
  
  def locked?
    locked
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
