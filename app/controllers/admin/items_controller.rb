class Admin::ItemsController < ApplicationController

  def new
    @admin_item = AdminItem.new
  end

  def create
    @admin_item = AdminItem.new(item_params)
    @admin_item.customer = current_customer
    @admin_item.save
    redirect_to items_path(@admin_item.id)
  end

  def index
    @item = Item.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:image, :product_name, :introduction, :price)
  end
end
