class OrdersController < ApplicationController 
  before_action :move_to_index

  def index
    @item = Item.find(params[:item_id]) #binding.pryでparamsの内容を確認     @item = Item.find(params[:id]
    @order_address = OrderAddress.new
    
  end
  
  def create
    @order_address = OrderAddress.new(postal_code: order_params[:postal_code],region_id: order_params[:region_id], city: order_params[:city], address_line: order_params[:address_line], building_number: order_params[:building_number], phone_number: order_params[:phone_number], user_id: order_params[:user_id], item_id: params[:item_id])
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end

  end

  private
  def move_to_index
    unless user_signed_in?
    redirect_to root_path
    end
  end

  # def order_params
  #   params.permit(:token)  #.merge(user_id: current_user.id )
  # end
  def order_params
    params.require(:order_address).permit(:postal_code, :region_id, :city, :address_line, :building_number, :phone_number).merge(token: params[:token], user_id: current_user.id) #merge(キー1: バリュー1,キー2: バリュー2)、なぜuser_idが必要？
  end

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
