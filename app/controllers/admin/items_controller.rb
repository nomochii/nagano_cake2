class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer = current_customer
    @item.save
    redirect_to items_path(@item.id)
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
    params.require(:item).permit(:Product_image, :product_name, :introduction, :price)
  end
end
