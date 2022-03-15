require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "商品出品" do
    context '商品出品がうまくいくとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品登録がうまくいかないとき' do
      it 'imageが空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空だと登録できない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空だと登録できない' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'categoryが未選択（＝idが1）だと登録できない' do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'conditionが未選択（＝idが1）だと登録できない' do
        @item.condition_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end
      it 'prefectureが未選択（＝idが1）だと登録できない' do
        @item.prefecture_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'shipping_feeが未選択（＝idが1）だと登録できない' do
        @item.shipping_fee_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee must be other than 1")
      end
      it 'shipping_scheduleが未選択（＝idが1）だと登録できない' do
        @item.shipping_schedule_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping schedule must be other than 1")
      end
      it 'priceが300円未満だと登録できない' do
        @item.price = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it 'priceが9,999,999円を超えると登録できない' do
        @item.price = "99999999"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'priceが半角英語だと登録できない' do
        @item.price = "test"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが全角文字だと登録できない' do
        @item.price = "１２３４５"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'userが紐付いていなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
