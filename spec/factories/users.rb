FactoryBot.define do
  factory :user do
    nickname { 'furima太郎' }
    email { Faker::Internet.unique.email }  # 一意のemailを生成する
    password  { 'aaaa0000'}
    password_confirmation { 'aaaa0000'}
    first_name { '山田' }
    last_name { '陸太郎' }
    first_name_kana { 'ヤマダ' }
    last_name_kana { 'リクタロウ' }
    birth_day { '1930-01-01' }
  end
end