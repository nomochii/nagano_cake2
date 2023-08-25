class Public::OrdersController < ApplicationController

   # 購入情報の入力画面で、宛先や住所などを入力する所
  def new
    @order = Order.new
  end

  # 購入を確定する
  def create    # Order に情報を保存する
    # ログインユーザーのカートアイテムを全て取り出して cart_items に入れる
    @cart_items = current_customer.cart_items.all
    # 渡ってきた値を @order に入れる
    @order = current_customer.orders.new(order_params)
    # ここに至るまでの間にチェックは済ませているが、念の為IF文で分岐させてる
    if @order.save
      cart_items.each do |cart|  # 取り出したカートアイテムの数繰り返し
      # order_item にも一緒にデータを保存する必要があるのでここで保存
        order_confirm = OrderConfirm.new
        order_confirm.customer_id = cart_item.current_customer
        order_confirm.order_id = @order.id
        order_confirm.order_amount = cart_item.amount
        # 購入が完了したらカート情報は削除するのでこちらに保存
        order_confirm.order_price = cart_item.item.price
        # カート情報を削除するので item との紐付けが切れる前に保存
        order_item.save
      end
      # 遷移したいページのパス
      redirect_to orders_complete_path
      # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除(カートを空にする)
      cart_items.destroy_all
    else
       @order = Order.new(order_params)
       render :new
    end
  end

  def index
    @orders = current_customer.orders
  end

  # new 画面から渡ってきたデータをユーザーに確認してもらう
  def confirm
    # new 画面から渡ってきたデータを @order に入れる
    @order = Order.new(order_params)
    # @order の各カラムに必要なものを入れる
    # 模索中
    # @order.name = current_customer.name
    # @order.customer_id = current_customer.id
    # @orders = current_customer.cart_items.all
    # @orders = current_customer.orders.all
    # @order.save
    redirect_to orders_complete_path
  end

  # def complete
  # end

  # def show
  #   @order = Order.find(params[:id])
  #   @ordere_details = @order.ordere_details
  # end


  def order_params
    params.require(:order).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :amount, :purchase_price, :item_id)
  end
end
