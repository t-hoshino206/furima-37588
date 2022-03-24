require 'rails_helper'

RSpec.describe OrderSendingInfo, type: :model do
  describe "商品出品" do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:user)
      @order_sending = FactoryBot.build(:order_sending_info, user_id: user.id, item_id: item.id)
    end

    context '購入処理に問題ない場合' do
      it '全ての項目が存在すれば購入できる' do
        expect(@order_sending).to be_valid
      end

      it 'buildingは空でも購入できる' do
        @order_sending.building = ""
        expect(@order_sending).to be_valid
      end
    end

    context '購入処理に問題がある場合' do
      it 'tokenが空だと購入できない' do
        @order_sending.token = nil
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'postal_codeが空だと購入できない' do
        @order_sending.postal_code = nil
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_sending.postal_code = "1234567"
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'postal_codeが全角文字だと購入できない' do
        @order_sending.postal_code = "１２３−４５６７"
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("郵便番号は不正な値です")
      end
      it 'prefectureが未選択（＝idが1）だと購入できない' do
        @order_sending.prefecture_id = "1"
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("都道府県は1以外の値にしてください")
      end
      it 'cityが空だと購入できない' do
        @order_sending.city = ""
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addressが空だと購入できない' do
        @order_sending.address = ""
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと購入できない' do
        @order_sending.phone_number = ""
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberがハイフンを含んだ形式であると購入できない' do
        @order_sending.phone_number = "090-1234-5678"
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが全角文字だと購入できない' do
        @order_sending.phone_number = "０９０１２３４５６７８"
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが9桁以下だと購入できない' do
        @order_sending.phone_number = "090"
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @order_sending.phone_number = "090123456789"
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'userが紐付いていないと購入できない' do
        @order_sending.user_id = nil
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていないと購入できない' do
        @order_sending.item_id = nil
        @order_sending.valid?
        expect(@order_sending.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
