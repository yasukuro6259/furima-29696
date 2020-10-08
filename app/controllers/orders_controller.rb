class OrdersController < ApplicationController
  before_action :move_to_index
  before_action :get_item_infomation, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.select_save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def move_to_index
    @item = Item.find(params[:item_id])
    if (user_signed_in? && current_user.id == @item.user_id) || @item.order.present?
      redirect_to root_path
    elsif user_signed_in? == false
      redirect_to new_user_session_path 
    end
  end

  def get_item_infomation
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :region_id, :city, :address_line, :building_number, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id]) # merge(キー1: バリュー1,キー2: バリュー2, ...)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
