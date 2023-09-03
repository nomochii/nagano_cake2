class Public::ItemsController < ApplicationController

  def index
     @items = Item.page(params[:page])
  end

  def show
    @item = Item.all
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end

  def update
    # customer = Customer.find(params[:id])
    # unless customer.id == current_customer.id
    # redirect_to root_path
    # end

     @item = Item.find(params[:id])
     @item.update(item_params)
     redirect_to  cart_items_path
  end

  def item_params
    params.require(:item).permit(:image, :product_name, :introduction, :price)
  end
end
