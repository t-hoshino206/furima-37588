require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context '新規登録がうまくいくとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    
    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名字フリガナを入力してください")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前フリガナを入力してください")
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = "testuser"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = "ab123"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it '半角英字のみのpasswordでは登録できない' do
        @user.password = "123456789"
        @user.password_confirmation = "123456789"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it '半角数字のみのpasswordでは登録できない' do
        @user.password = "abcdefg"
        @user.password_confirmation = "abcdefg"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it '全角文字を含むpasswordでは登録できない' do
        @user.password = "abc１２３"
        @user.password_confirmation = "abc１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'last_nameが半角では登録できない' do
        @user.last_name = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は不正な値です")
      end
      it 'first_nameが半角では登録できない' do
        @user.first_name = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は不正な値です")
      end
      it 'last_name_kanaが半角では登録できない' do
        @user.last_name_kana = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字フリガナは不正な値です")
      end
      it 'last_name_kanaが全角（漢字・ひらがな）では登録できない' do
        @user.last_name_kana = "てすと"
        @user.valid?
        expect(@user.errors.full_messages).to include("名字フリガナは不正な値です")
      end
      it 'first_name_kanaが半角では登録できない' do
        @user.first_name_kana = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前フリガナは不正な値です")
      end
      it 'first_name_kanaが全角（漢字・ひらがな）では登録できない' do
        @user.first_name_kana = "てすと"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前フリガナは不正な値です")
      end
    end
  end
end
