class OrdersController < ApplicationController
  before_action :move_to_index

  def index
    @item = Item.find(params[:item_id]) # binding.pryでparamsの内容を確認     @item = Item.find(params[:id]
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.select_save
      redirect_to root_path
    else
      redirect_to item_path(params[:item_id])
    end
  end

  private

  def move_to_index
    @item = Item.find(params[:item_id])
    if user_signed_in? == false
      redirect_to root_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    elsif @item.order.present?
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :region_id, :city, :address_line, :building_number, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id]) # merge(キー1: バリュー1,キー2: バリュー2, ...)
  end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
