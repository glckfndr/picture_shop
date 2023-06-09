class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, null: false,  precision: 8, scale: 2, default: 0.0
      t.integer :balance, null: false, default: 0

      t.timestamps
    end
  end
end
