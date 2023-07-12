class CartManager::Summator < CartService
  def call
    return 0 if current_cart.empty?

    ids = current_cart.keys.map(&:to_i)
    prices = Product.find(ids).map(&:price).to_enum
    amounts = current_cart.values.map { |data| data[:amount] || data['amount'] }
    amounts.inject(0) { |total_price, amount| total_price + (prices.next * amount) }
  end
end
