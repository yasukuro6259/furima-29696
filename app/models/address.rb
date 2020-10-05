class Address < ApplicationRecord
  belongs_to :order
  belongs_to_active_hash :region

  # with_option presense: true do
  # validates :potal_code, :region, :region, :city, :address_line, :building_number, :phone_number
  # end

  # POTAL_RULE = /\A\d{3}-\d{4}\z/
  # validates_format_of :postal_code, with: POTAL_RULE, message: 'には - を含めて設定してください'
  # PHONE_NUMBER_RULE = /\A\d{11}\z/
  # validates_format_of :phone_number, with: PHONE_NUMBER_RULE, message: '正しい携帯番号を入力してください'

# - 配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
# - 郵便番号にはハイフンが必要であること（123-4567となる）
# - 電話番号にはハイフンは不要で、11桁以内であること

end
