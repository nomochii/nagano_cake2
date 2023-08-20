class Public::ItemsController < ApplicationController

  def index
     @items = Item.all
    # @items = Item.count
  end

  def show
    @item = Item.all
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end

  def update
     @item = Item.find(params[:id])
     @item.update(item_params)
      redirect_to  cart_items_path
  end

  def item_params
    params.require(:item).permit(:image, :product_name, :introduction, :price)
  end
end
