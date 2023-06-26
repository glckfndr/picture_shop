class CartManager::BalanceDecreaser < CartService
  def serve
    current_cart.each do |id, data|
      product = Product.find(id)
      product.balance = product.balance - data['amount']
      product.save
    end
  end
end
