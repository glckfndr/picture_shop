class ChangeProductBalance < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :balance, :integer,  default: 0
  end
end
