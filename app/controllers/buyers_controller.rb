class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:index, :create]

  def index
    @buyer_shipment = BuyerShipment.new
  end

  def create
    @buyer_shipment = BuyerShipment.new(buyer_params)

    if @buyer_shipment.valid?
      @buyer_shipment.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def buyer_params
    params.require(:buyer_shipment).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, product_id: @product.id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end