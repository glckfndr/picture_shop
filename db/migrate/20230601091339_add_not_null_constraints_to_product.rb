class AddNotNullConstraintsToProduct < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :name, false
    change_column_null :products, :price, false
    change_column_null :products, :balance, false
  end
end
