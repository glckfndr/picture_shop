class Order < ApplicationRecord
  scope :ordered, -> { order(created_at: :desc) }

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders

  validates :first_name, :last_name, :address, :phone, presence: true

  def order_info
    {
      order: self,
      total_sum: order_cost,
      products: product_info
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

  private

  ProductInfo = Struct.new(:name, :price, :quantity, :amount_sum)

  def product_info
    product_orders.map do |product_order|
      ProductInfo.new(
        product_order.product.name,
        product_order.product.price,
        product_order.amount,
        product_order.product.price * product_order.amount
      )
    end
  end

  def order_cost
    product_orders.map.inject(0) do |sum, product_order|
      sum + (product_order.product.price * product_order.amount)
    end
  end
end
