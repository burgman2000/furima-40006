class BuyersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create]
  
  def index
    @product = Product.find(params[:product_id])
    @buyer_shipment = BuyerShipment.new
  end

  def new
  end



  def create
    @buyer_shipment = BuyerShipment.new(buyer_params)

    if @buyer_shipment.valid?
      @buyer_shipment.save
      redirect_to root_path
    else
      @product = Product.find(params[:product_id])
      render :index, status: :unprocessable_entity
    end
  end



  private


  def buyer_params
    params.permit(:user, :product, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :product_id).merge(user_id: current_user.id)
  end

  


end
