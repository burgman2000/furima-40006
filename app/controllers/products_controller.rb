class ProductsController < ApplicationController

  before_action :set_product, only: [:edit, :show , :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  

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

  def edit
    
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path    
  end

  def show
    
  end


  
  private

  def product_params
    params.require(:product).permit(:image, :product_name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :price,).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_user
    

    unless  current_user.id == @product.user_id
      flash[:alert] = '他のユーザーの商品は編集できません。'
      redirect_to root_path
    end
  end

    
end
