class Public::CartItemsController < ApplicationController

  def index
    @customer = current_customer
    @cart_items = CartItem.all
    @items = Item.all
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    if @cart_item.update(cart_item_params)
      redirect_to  cart_items_path(@cart_item.id)
    else
      render :index
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item_all = CartItem.all
    @cart_item_all.destroy
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path(@cart_item.id)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_name, :image, :amount, :purchase_price, :item_id)
  end

end
