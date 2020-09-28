require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nickname,email,password,password_confirmation,名前（全角）,フリガナ,生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが40文字以下で登録できる' do
        @user.nickname = 'abcdefghijabcdefghijabcdefghijabcdefghij'
        expect(@user).to be_valid
      end
      it 'passwordが半角英字半角数字両方を含めて6文字以上であれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '同じメールアドレスは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは@を含まないと登録できない' do
        @user.email = 'hogefugagmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下だと登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは確認用のパスワードが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '苗字が空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name は全角文字で設定してください')
      end
      it '名が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角文字で設定してください')
      end
      it '苗字に半角英数字が存在すると登録できない' do
        @user.family_name = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name は全角文字で設定してください')
      end
      it '名に半角英数字が存在すると登録できない' do
        @user.first_name = 'def456'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角文字で設定してください')
      end
      it '苗字のフリガナが空だと登録できない' do
        @user.ja_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Ja family name は全角カタカナで設定してください')
      end
      it '名のフリガナが空だと登録できない' do
        @user.ja_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Ja first name は全角カタカナで設定してください')
      end
      it '苗字のフリガナに半角英数字が存在すると登録できない' do
        @user.ja_family_name = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Ja family name は全角カタカナで設定してください')
      end
      it '名のフリガナに半角英数字が存在すると登録できない' do
        @user.ja_first_name = 'def456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Ja first name は全角カタカナで設定してください')
      end
      it '苗字のフリガナにひらがなが存在すると登録できない' do
        @user.ja_family_name = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include('Ja family name は全角カタカナで設定してください')
      end
      it '名のフリガナにひらがなが存在すると登録できない' do
        @user.ja_first_name = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Ja first name は全角カタカナで設定してください')
      end
      it '苗字のフリガナに漢字が存在すると登録できない' do
        @user.ja_family_name = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include('Ja family name は全角カタカナで設定してください')
      end
      it '名のフリガナに漢字が存在すると登録できない' do
        @user.ja_first_name = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('Ja first name は全角カタカナで設定してください')
      end
      it '生年月日が空だと登録できない' do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end

# ニックネームが必須であること
# メールアドレスが必須であること
# メールアドレスが一意性であること
# メールアドレスは@を含む必要があること
# パスワードが必須であること
# パスワードは6文字以上であること
# パスワードは半角英数字混合であること
# パスワードは確認用を含めて2回入力すること
# 新規登録・ログイン共にエラーハンドリングができていること（適切では無い値が入力された場合、情報は受け入れられず、エラーメッセージを出力させる）
