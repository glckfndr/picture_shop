class AddNotNullConstraintsToProductOrder < ActiveRecord::Migration[7.0]
  def change
    change_column_null :product_orders, :amount, false
  end
end
