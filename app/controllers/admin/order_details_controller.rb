class Admin::OrderDetailsController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.shipping_postal_code = customer.postal_code
    @order.shipping_address = customer.address
    @order.shipping_name = customer.first_name + customer.last_name
    @order.postage = 800
    @order.payment_method = customer.payment_method
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_amount = @total + @order.postage
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :amount, :purchase_price)
  end

end
