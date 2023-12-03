class Product < ApplicationRecord 

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day 

  belongs_to :user
  has_one :buyer, dependent: :destroy
  has_one_attached :image
  has_many :buyers, dependent: :destroy
  


  validates :image, presence: true
  validates :product_name, presence: true
  validates :description , presence: true
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }, if: :price_present?
  
  def sold_out?
    buyer.present?
  end

  private

  def price_present?
    price.present?
  end

  

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :shipping_fee_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"} 


  
end
