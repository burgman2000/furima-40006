class Buyer < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :shipment
  has_many :shipments, dependent: :destroy
end
