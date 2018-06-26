class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts_products do |t|
      t.integer :cart_id, null: :false, index: :true
      t.integer :product_id, null: :false, index: :true
      t.timestamps
    end
  end
end
