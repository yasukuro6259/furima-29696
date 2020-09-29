class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private
  def item_params
    prams.require(:item).permit(:name, :image, :price).merge(user_id: current_user.id)
  end
end
