class OrderAddress
  include ActiveModel::Model # モジュール、Formオブジェクトを使用できるようになる。
  attr_accessor :postal_code, :region_id, :city, :address_line, :building_number, :phone_number, :order_id, :user_id, :item_id, :token
  # 属性を使えるようになる ゲッターセッターの原理 @postal_code = postal_code
  with_options presence: true do
    validates :postal_code, :region_id, :city, :address_line, :phone_number, :user_id, :item_id, :token
  end
  POSTAL_RULE = /\A\d{3}-\d{4}\z/.freeze
  validates_format_of :postal_code, with: POSTAL_RULE, message: 'には - を含めて設定してください'
  PHONE_NUMBER_RULE = /\A\d{10,11}\z/.freeze
  validates_format_of :phone_number, with: PHONE_NUMBER_RULE, message: 'を正しく入力してください'
  def select_save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, region_id: region_id, city: city, address_line: address_line, building_number: building_number, phone_number: phone_number, order_id: order.id)
  end
end
