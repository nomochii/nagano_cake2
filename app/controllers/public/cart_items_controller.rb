class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items.all
    @items = Item.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
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
    @cart_item = CartItem.find(params[:id]) # データ（レコード）を1件取得
    @cart_item.destroy # データ（レコード）を削除
    @cart_items = CartItem.all# 削除後のカート内全件取得
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }# 削除後のカート内の合計
    render :index
  end

  def destroy_all
    @cart_item_all = CartItem.all# データ（レコード）を全件取得
    @cart_item_all.destroy.all# データ（レコード）を全件削除
    render :index
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
