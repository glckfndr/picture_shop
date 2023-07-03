class CartManager::BalanceDecreaser < CartService
  def serve
    Product.transaction do
      products = Product.find(current_cart.keys)
      products.each do |product|
        product.balance = product.balance - current_cart[product.id.to_s]['amount']
        product.save
      end
    end
  end
end
