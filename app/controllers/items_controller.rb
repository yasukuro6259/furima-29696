class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :description, :price, :category_id, :condition_id, :fee_id, :region_id, :shipping_day_id).merge(user_id: current_user.id)
  end
end
