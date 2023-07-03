class CartManager::Decreaser < CartService
  def serve
    return unless current_cart.key?(@id)

    current_cart[@id]['amount'] -= 1 if current_cart[@id]['amount'].positive?
  end
end