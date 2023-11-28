class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :destroy, :edit, :update, :show]

  def index
    @products = Product.order("created_at DESC")    
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  
  private

  def product_params
    params.require(:product).permit(:image, :product_name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :price,).merge(user_id: current_user.id)
  end

    
end
