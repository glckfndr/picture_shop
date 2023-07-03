class CartManager::Adder < CartService
  def serve
    if current_cart.key?(@id)
      current_cart[@id]['amount'] += 1 if current_cart[@id]['amount'] < current_cart[@id]['balance']
    else
      current_cart[@id] = { 'amount' => 1, 'balance' => @balance }
    end
  end
end