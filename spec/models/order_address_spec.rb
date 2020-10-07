require 'rails_helper'
RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '購入機能' do
    context '購入がうまくいくとき' do
      it '郵便番号、住所（都道府県、市町村、番地）、電話番号、購入ユーザーid、購入商品id、トークンが存在すれば登録できる' do
        expect(@order_address).to be_valid
      end
      it '電話番号が11桁以下で登録できる' do
        @order_address.phone_number = '09011111111'
        expect(@order_address).to be_valid
      end
      it '郵便番号が3桁-4桁であれば登録できる' do
        @order_address.postal_code = '331-4949'
        expect(@order_address).to be_valid
      end
    end

    context '購入がうまくいかないとき' do
      it '郵便番号が空だと登録できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank", 'Postal code には - を含めて設定してください')
      end

      it '郵便番号に「-」がないと登録できない' do
        @order_address.postal_code = '3310804'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code には - を含めて設定してください')
      end

      it '都道府県が空では登録できない' do
        @order_address.region_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Region can't be blank")
      end

      it '市町村が空では登録できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では登録できない' do
        @order_address.address_line = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address line can't be blank")
      end

      it '電話番号が空では登録できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が12桁以上では登録できない' do
        @order_address.phone_number = '028242334233'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number を正しく入力してください')
      end

      it '購入したユーザのidが空では登録できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it '購入商品のidが空では登録できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'トークンが空では登録できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
