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
  
  validates :name, length: { maximum: 40 }, presence: true
  validates :description, length: { maximum: 1000 }, presence: true
  validates :price, numericality: {only_integer:true, greater_than: 299,less_than: 10000000} #numericalityは数値に関するvalidates
  validates :category, :condition, :fee, :region, :shipping_day, presence: true
  validates :category_id, :condition_id, :fee_id, :region_id, :shipping_day_id, numericality: { other_than: 1 }
end
