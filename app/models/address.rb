class Address < ApplicationRecord
  belongs_to :order

# - 配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
# - 郵便番号にはハイフンが必要であること（123-4567となる）
# - 電話番号にはハイフンは不要で、11桁以内であること

end
