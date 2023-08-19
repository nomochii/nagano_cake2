class Public::CartItemsController < ApplicationController

  def index
    @customer = current_customer
    @customer = Customer.all
    @cart_items = CartItem.all
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to  cart_item_path(@cart_item.id)
    else
      render :edit
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
    @new_cart_item = CartItem.new(cart_item_params)
    @new_cart_item.save
    redirect_to admin_item_path(@new_cart_item.id)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_name, :image, :amount, :purchase_price)
  end

end
