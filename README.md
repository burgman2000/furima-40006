# README



# テーブル設計

## users テーブル

| Column                | Type     | Options     |
| ------------------    | ------   | ----------- |
| nickname              | string   | null: false |
| email                 | string   | null: false |unique: true
| password              | string   | null: false |CHECK (password REGEXP '^(?=.*[a-z])(?=.*[0-9]).{6,}$')
| password_confirmation | string   | null: false |CHECK (password REGEXP '^(?=.*[a-z])(?=.*[0-9]).{6,}$')
| first_name            | nvarchar | null: false |
| last_name             | nvarchar | null: false |
| first_name_kana       | nvarchar | null: false |
| last_name_kana        | nvarchar | null: false |
| birth_year            | string   | null: false |
| birth_month           | string   | null: false |
| birth_day             | string   | null: false |



##  products  テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| product_name       | string    | null: false |
| description        | text      | null: false |
| category           | string    | null: false |
| condition          | string    | null: false |
| shipping_fee       | string    | null: false |
| origin_region      | string    | null: false |
| shipping_days      | string    | null: false |
| price              | integer   | null: false |CHECK (price >= 300 AND price <= 9999999)
| user_id            | references| null: false |foreign_key: true



##   buyers   テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| user_id            | references| null: false |foreign_key: true
| products_id        | references| null: false |foreign_key: true
+----------------------------------------+




##   shipments  テーブル

| Column             | Type              | Options     |
| ------------------ | ------            | ----------- |
| postal_code        | integer           | null: false 
| prefecture         | string            | null: false
| city               | string            | null: false
| street_address     | string            | null: false |limit: 8, format: { with: /\A\d{3}-\d{4}\z/ }
| building_name      | string            | 
| phone_number       | string            | null: false | limit: 11
| user_id            | references        | null: false |foreign_key: true
| products_id        | references        | null: false |foreign_key: true
| buyers_id          | references        | null: false |foreign_key: true
+----------------------------------------+


### Association
- has_many :product
- has_many :buyer

- belongs_to :user
- has_one :buyer

- belongs_to :user
- belings_to :producut
- has_one :shipment

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
