class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :street_address, null: false, limit: 8
      t.string :building_name
      t.string :phone_number, null: false, limit: 11
      t.references :buyer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
