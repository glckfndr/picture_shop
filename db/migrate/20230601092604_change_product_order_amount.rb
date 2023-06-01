class ChangeProductOrderAmount < ActiveRecord::Migration[7.0]
  def change
    change_column :product_orders, :amount, :integer,  default: 0
  end
end
