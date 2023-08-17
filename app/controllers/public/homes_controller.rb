class Public::HomesController < ApplicationController
  def top
    @items = Item.all
  end

  def about

  end

  def item_params
    params.require(:item).permit(:image, :product_name, :price)
  end
end
