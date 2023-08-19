class Public::CartItemsController < ApplicationController

  def index
    @customer = current_customer
    @customer = Customer.all
    @cart_items = Cart_item.all
  end

  def update
    @cart_item = Cart_item.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to  admin_item_path(@item.id)
    else
      render :edit
    end
  end

end
