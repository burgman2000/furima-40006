class Buyer < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipment
end
