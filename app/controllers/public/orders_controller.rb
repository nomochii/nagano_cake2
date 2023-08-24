class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @orders = current_customer.orders.all
    @order.save
    redirect_to order_path
  end

  def index
    @orders = current_customer.orders
  end

  def confirm
    @order = Order.new(order_params)
    # @order.customer_id = current_customer.id
    # @cart_items = current_customer.cart_items.all
    # @orders = current_customer.orders.all
    # @order.save
    # redirect_to orders_complete_path
  end


  def complete
  end

  def show
    @order = Order.find(params[:id])
    @ordere_details = @order.ordere_details
  end


  def order_params
    params.require(:order).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :amount, :purchase_price, :item_id)
  end
end
