class AddNotNullConstraintsToOrder < ActiveRecord::Migration[7.0]
  def change
    change_column_null :orders, :first_name, false
    change_column_null :orders, :last_name, false
    change_column_null :orders, :address, false
    change_column_null :orders, :phone, false
  end
end
