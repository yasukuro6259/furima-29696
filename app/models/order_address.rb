class OrderAddress
  include ActiveModel::Model #モジュール、Formオブジェクトを使用できるようになる。
  attr_accessor :postal_code, :region_id, :city, :address_line, :building_number, :phone_number, :order_id, :user_id, :item_id
  # 属性を使えるようになる ゲッターセッターの原理 @postal_code = postal_code
  with_options presence: true do
    validates :postal_code, :region_id, :city, :address_line, :phone_number, :user_id, :item_id
  end    
    POSTAL_RULE = /\A\d{3}-\d{4}\z/
    validates_format_of :postal_code, with: POSTAL_RULE, message: 'には - を含めて設定してください'
    PHONE_NUMBER_RULE = /\A\d{11}\z/
    validates_format_of :phone_number, with: PHONE_NUMBER_RULE, message: '正しい携帯番号を入力してください'
    # バリデーションは複数モデルの情報をまとめる
    # - 配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
    # - 郵便番号にはハイフンが必要であること（123-4567となる）
    # - 電話番号にはハイフンは不要で、11桁以内であること
    def save
      order = Order.create(user_id: user_id, item_id: item_id) #createメソッドを使って変数に代入できるの？
      Address.create(postal_code: postal_code, region_id: region_id, city: city, address_line: address_line, building_number: building_number, phone_number: phone_number, order_id: order.id)
    end
    # 複数テーブルの情報を保存できるメソッドを設定（createアクションで保存されないの？）
    # アクティブハッシュのアソシエーションは記載しなくていい？
end

  