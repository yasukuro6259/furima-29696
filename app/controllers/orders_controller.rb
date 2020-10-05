class OrdersController < ApplicationController 
  before_action :move_to_index

  def index
    @item = Item.find(params[:item_id]) #binding.pryでparamsの内容を確認
  end

  def create
    @order = Order.new(user_id: current_user.id, item_id: params[:item_id])
    if @order.valid? #エラーメッセージを@orderに含めるため
      pay_item
      @order.save
      return redirect_to root_path
    else
      redirect_to item_path(@item.id)
    end

    # @address = Address.new(address_params)
    # if @address.valid?
    #   pay_item
    #   @address.save
    #   return redirect_to root_path
    # else
    #   redirect_to item_path(@item.id)
    # end
  end

  private
  def move_to_index
    unless user_signed_in?
    redirect_to root_path
    end
  end

  def order_params
    params.permit(:token)  #.merge(user_id: current_user.id )
  end

  # def address_params
  #   params.permit(:potal_code, :region_id, :city, :address_line, :building_number, :phone_number, :order_id)
  # end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = "sk_test_8f350ff5cbb40cbf8a94ea73" # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency:'jpy'
    )
  end

end
