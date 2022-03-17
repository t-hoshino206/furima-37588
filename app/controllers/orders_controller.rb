class OrdersController < ApplicationController
  def index
    # ルーティングのparamsから商品のidを取得している
    @item = Item.find(params[:item_id])
    # form_withに渡す、フォームオブジェクトの空のインスタンスを生成
    @order_sending_info = OrderSendingInfo.new
  end

  def create
    @order_sending_info = OrderSendingInfo.new(order_sending_info_params)
    # フォームオブジェクトクラスはActiveRecordを継承していないのでvalid?を実行してバリデーションを実行する必要がある。
    if @order_sending_info.valid?
      # バリデーションを通過すればフォームオブジェクトで定義したsaveメソッドを実行
      @order_sending_info.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private
  
  def order_sending_info_params
    params.require(:order_sending_info).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id].to_i)
  end
end
