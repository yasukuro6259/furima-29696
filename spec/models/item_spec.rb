require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品登録' do
    context '出品登録がうまくいくとき' do
      it 'name,description,price,categoru_id, condition_id, fee_id, region_id, shipping_days_id,user_idが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'descriptionが1000文字以下で登録できる' do
        @item.description = 'abcdefghijabcdefghijabcdefghijabcdefghij'
        expect(@item).to be_valid
      end
      it 'priceが300以上9999999以下であれば登録できる' do
        @item.price = 500_000
        expect(@item).to be_valid
      end
    end

    context '出品登録がうまくいかないとき' do
      it '商品登録が空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品説明が1000文字を超えると登録できない' do
        text = 't' * 1001
        @item.description = text
        @item.valid?
        expect(@item.errors.full_messages).to include('Description is too long (maximum is 1000 characters)')
      end
      it '値段が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '値段が300円未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 299')
      end
      it '値段が10000000円以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 10000000')
      end
      it '値段が全角では登録できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it '画像が空では登録できない' do
        @item.image = nil # ""だとエラーが起きる
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'カテゴリー情報が空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", 'Category is not a number')
      end

      it 'カテゴリー情報が「---」(id = 1)では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it '商品の状態が空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank", 'Condition is not a number')
      end

      it '商品の状態が「---」(id = 1)では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end

      it '配送料負担が空では登録できない' do
        @item.fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Fee can't be blank", 'Fee is not a number')
      end

      it '配送料負担が「---」(id = 1)では登録できない' do
        @item.fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Fee must be other than 1')
      end

      it '発送元の地域が空では登録できない' do
        @item.region_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Region can't be blank", 'Region is not a number')
      end

      it '発送元の地域が「---」(id = 1)では登録できない' do
        @item.region_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Region must be other than 1')
      end

      it '発送までの日数が空では登録できない' do
        @item.shipping_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank", 'Shipping day is not a number')
      end
      it '発送まで日数が「---」(id = 1)では登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day must be other than 1')
      end
    end
  end
end
