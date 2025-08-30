class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.decimal :total_price, precision: 17, scale: 2, null: false, default: 0.0
      t.integer :status, null: false, default: 0
      t.datetime :last_activity_at
      
      t.timestamps
    end
  end
end
