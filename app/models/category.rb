class Category < ActiveRecord::Base
  has_many :books, dependent: :nullify
  
  validates :name, presence: true
  validates :slug, presence: true
end
