FactoryBot.define do
  factory :product do
    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    shipping_fee_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    shipping_day_id { Faker::Number.between(from: 2, to: 4) }
    association :user
    product_name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    price { 1000 }
    

   

    after(:build) do |product|
      product.image.attach(io: File.open(Rails.root.join('public/images/test_image.png')), filename: 'test_image.png')
    end
  end
end