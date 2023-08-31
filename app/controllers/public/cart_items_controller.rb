class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.update(cart_item_params)
    redirect_to  cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id]) # データ（レコード）を1件取得
    @cart_item.destroy # データ（レコード）を削除
    @cart_items = CartItem.all# 削除後のカート内全件取得
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }# 削除後のカート内の合計
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items_all = current_customer.cart_items# 自分のカートアイテムデータ（レコード）だけを取得
    @cart_items_all.destroy_all# 自分のカートアイテムデータ（レコード）だけを全件削除
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        if cart_item.item_id == @cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
        end
      end
      @cart_item.save
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_name, :image, :amount, :purchase_price, :item_id)
  end

end
