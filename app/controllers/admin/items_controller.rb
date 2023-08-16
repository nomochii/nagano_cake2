class Admin::ItemsController < ApplicationController

  def new
    @newitem = Item.new
  end

  def create
    @newitem = Item.new(item_params)

    @newitem.save!
    redirect_to admin_item_path(@newitem.id)
  end

  def index
    @admin = current_admin
    @admin = Admin.all
    @items = Item.all
    @newitem = Item.new
  end


  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])

    @newitem = Item.new
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

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end


  private

  def item_params
    params.require(:item).permit(:image, :product_name, :introduction, :price)
  end
end
