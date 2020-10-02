class OrdersController < ApplicationController 
  before_action :move_to_index

  def index
    @item = Item.find(params[:item_id]) #binding.pryでparamsの内容を確認
  end

  private
  def move_to_index
    unless user_signed_in?
    redirect_to root_path
    end
  end
end
