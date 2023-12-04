class BuyerShipment
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number
  attr_accessor :token
  attr_accessor :user, :product

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁ハイフン4桁」の半角文字列で入力してください' }
    validates :prefecture_id, presence: true, numericality: { other_than: 1, message: 'は1以外の値にしてください' }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以内の半角数値で入力してください' }
    validates :user_id
    validates :product_id
    validates :token
  end

  
  

  def save
    buyer_instance = Buyer.create(user_id: user_id, product_id: product_id)
    Shipment.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building_name: building_name, phone_number: phone_number, buyer_id: buyer_instance.id)
  end

  

  
end