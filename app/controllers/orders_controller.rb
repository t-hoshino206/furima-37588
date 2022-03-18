class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    # ルーティングのparamsから商品のidを取得している
    @item = Item.find(params[:item_id])

    if @item.order
      redirect_to root_path
    elsif @item.user == current_user
      redirect_to item_path(@item.id)
    else
      # form_withに渡す、フォームオブジェクトの空のインスタンスを生成
      @order_sending = OrderSendingInfo.new
    end
  end

  def create
    @order_sending = OrderSendingInfo.new(order_sending_params)
    # フォームオブジェクトクラスはActiveRecordを継承していないのでvalid?を実行してバリデーションを実行する必要がある。
    if @order_sending.valid?
      set_payitem
      # バリデーションを通過すればフォームオブジェクトで定義したsaveメソッドを実行
      @order_sending.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private
  
  def set_payitem
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item[:price], # 商品の値段
      card: order_sending_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
  
  def order_sending_params
    params.require(:order_sending_info).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
