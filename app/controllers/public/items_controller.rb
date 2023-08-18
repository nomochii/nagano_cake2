class Public::ItemsController < ApplicationController

  def index
     @items = Item.all
    # @items = Item.count
  end


  def item_params
    params.require(:item).permit(:image, :product_name, :price)
  end
end
