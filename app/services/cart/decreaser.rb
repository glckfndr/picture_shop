class Cart::Decreaser < CartService

  def serve
    if current_cart.has_key?(@id)
      current_cart[@id] -= 1 if current_cart[@id] > 0
    end
  end

end
