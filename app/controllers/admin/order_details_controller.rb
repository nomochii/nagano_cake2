class Admin::OrderDetailsController < ApplicationController

  def show
    @order = order.find(params[:id])
    @orders = @order.order_details
    # @order = Order.find(params[:id])
    # @order = @order_detail.order
    # @order_detail = OrderDetail.find(params[:id])
    # @order_details = @order.order_details
    # @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    # @order.postage = 800
    # @order.total_amount = @total + @order.postage
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :amount, :purchase_price)
  end

end
