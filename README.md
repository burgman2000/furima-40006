# README



# テーブル設計

## users テーブル

| Column                | Type     | Options     |
| ------------------    | ------   | ----------- |
| nickname              | string   | null: false |
| email                 | string   | null: false , unique: true |
| encrypted_password    | string   | null: false |☆
| first_name            | string   | null: false |
| last_name             | string   | null: false |
| first_name_kana       | string   | null: false |
| last_name_kana        | string   | null: false |
| birth_day             | date     | null: false |

### Association
- has_many :products
- has_many :buyers



##  products  テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| product_name       | string    | null: false |
| description        | text      | null: false |
| category_id        | integer   | null: false |
| condition_id       | integer   | null: false |
| shipping_fee_id    | integer   | null: false |
| prefecture_id      | integer   | null: false |
| shipping_day _id   | integer   | null: false |
| price              | integer   | null: false |CHECK (price >= 300 AND price <= 9999999)
| user               | references| null: false , foreign_key: true |


### Association
- belongs_to :user
- has_one :buyer



##   buyers   テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| user               | references| null: false, foreign_key: true |
| products           | references| null: false, foreign_key: true |
+----------------------------------------+

### Association
- belongs_to :user
- belongs_to :producut
- has_one :shipment



##   shipments  テーブル

| Column             | Type              | Options     |
| ------------------ | ------            | ----------- |
| postal_code        | string            | null: false 
| prefecture_id      | integer           | null: false
| city               | string            | null: false
| street_address     | string            | null: false |limit: 8, format: { with: /\A\d{3}-\d{4}\z/ }
| building_name      | string            | 
| phone_number       | string            | null: false | limit: 11
| buyer              | references        | null: false  , foreign_key: true
+----------------------------------------+


### Association
- belongs_to :product
























This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
