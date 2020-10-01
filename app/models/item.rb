class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :fee
  belongs_to_active_hash :region
  belongs_to_active_hash :shipping_day
  has_many :comments
  has_one :purchase_item

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }
    validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000 } # numericalityは数値に関するvalidates
    validates :image, :category, :condition, :fee, :region, :shipping_day # _idがつかない理由を説明できない。
    validates :category_id, :condition_id, :fee_id, :region_id, :shipping_day_id, numericality: { other_than: 1 }
  end
end
