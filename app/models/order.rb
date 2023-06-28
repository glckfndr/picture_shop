class Order < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :first_name, :last_name, :address, :phone, presence: true

  def order_info
    {
      order: self,
      total_sum: product_orders.map.inject(0) { |sum, po| sum + (po.product.price * po.amount) },
      products: product_orders.map do |po|
                  { name: po.product.name, price: po.product.price, quantity: po.amount,
                    sum: po.product.price * po.amount }
                end
    }
  end
end
