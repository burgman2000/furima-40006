class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @buyer_shipment = BuyerShipment.new
    redirect_if_invalid_access
  end

  def create
    @buyer_shipment = BuyerShipment.new(buyer_params)
    if @buyer_shipment.valid?
      pay_item
      @buyer_shipment.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def buyer_params
    params.require(:buyer_shipment).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, product_id: @product.id, token: params[:token])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
    Payjp::Charge.create(
      amount: @product.price,  
      card: @buyer_shipment.token,
      currency: 'jpy'                 
      )
    
  end

  def redirect_if_invalid_access
    if current_user.id == @product.user_id || @product.sold_out?
      redirect_to root_path, alert: "You cannot access this page."
    end
  end


end