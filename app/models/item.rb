class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_one :purchase_item
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
