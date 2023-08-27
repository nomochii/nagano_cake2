class Public::OrdersController < ApplicationController

   # 購入情報の入力画面で、宛先や住所などを入力する所（フォームを作成するのに使う）
  def new
    @order = Order.new
  end


  def create
    order = Order.new(order_params)
    order.customer_id = current_customer.id
    order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order = OrderDetail.new
      @order.order_id = order.id
      @order.item_id = cart_item.item.id
      @order.amount = cart_item.amount
      @order.purchase_price = cart_item.item.price * 1.1
      @order.save!
    end
        @cart_items.destroy_all
        redirect_to orders_complete_path
  end

  def index
    @order = current_customer
    @order = Customer.all
    @order = Order.all
    @order = Order.new
  end

  # new 画面から渡ってきたデータをユーザーに確認してもらう
  def confirm
    # new 画面から渡ってきたデータを @order に入れる
    @order = Order.new(order_params)
    @order.shipping_postal_code = current_customer.postal_code
    @order.shipping_address = current_customer.address
    @order.shipping_name = current_customer.first_name + current_customer.last_name
    @order.postage = 800
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_amount = @total + @order.postage

  end

  def complete
  end

  def show
    # @order = Order.find(params[:id])
    # @ordere_details = @order.ordere_details
  end


  def order_params
    params.require(:order).permit(:shipping_postal_code, :shipping_address, :shipping_name, :payment_method, :customer_id, :total_amount, :postage )
  end
end
