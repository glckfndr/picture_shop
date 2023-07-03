class Order < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :first_name, :last_name, :address, :phone, presence: true

  def order_info
    {
      order: self,
      total_sum: product_orders.map.inject(0) do |sum, product_order|
                   sum + (product_order.product.price * product_order.amount)
                 end,
      products: product_orders.map do |product_order|
        OpenStruct.new(
          name: product_order.product.name,
          price: product_order.product.price,
          quantity: product_order.amount,
          sum: product_order.product.price * product_order.amount
        )
      end
    }
  end

  def restore_balance
    Order.transaction do
      product_orders.each do |product_order|
        product = product_order.product
        product.balance = product.balance + product_order.amount
        product.save
      end
    end
  end
end
