class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_one :purchase_item
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :fee
  belongs_to_active_hash :shipping_day
  
  validates :name, :description, :price, :category, :condition, :fee, :region, :shipping_day, presence: true
  validates :category_id, :condition_id, :fee_id, :region_id, :shipping_day_id, numericality: { other_than: 1 }
  
end
