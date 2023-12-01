class BuyersController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
    @product = Product.find(params[:product_id])    
  end

  def new
  end



  def create
    @buyer = Buyer.create(buyer_params)
    Shipment.create(shipment_params)
    redirect_to root_path
  end



  private


  def buyer_params
    params.permit(:buyer).merge(user_id: current_user.id, product_id: params[:product_id])
  end

  def shipment_params
    params.permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(buyer_id: @buyer.id)
    
  end


end
