class Admin::ItemsController < ApplicationController

  def new
    @admin_item = Item.new
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
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end
  
  def update
     @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:image, :product_name, :introduction, :price)
  end
end
