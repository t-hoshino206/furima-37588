class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
    # ルーティングのparamsから商品のidを取得している
    @item = Item.find(params[:item_id])

    if @item.user == current_user
      redirect_to item_path(@item.id)
    else
      # form_withに渡す、フォームオブジェクトの空のインスタンスを生成
      @order_sending = OrderSendingInfo.new
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order_sending = OrderSendingInfo.new(order_sending_params)
    # フォームオブジェクトクラスはActiveRecordを継承していないのでvalid?を実行してバリデーションを実行する必要がある。
    if @order_sending.valid?
      # バリデーションを通過すればフォームオブジェクトで定義したsaveメソッドを実行
      @order_sending.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  
  def order_sending_params
    params.require(:order_sending_info).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id].to_i)
  end
end
