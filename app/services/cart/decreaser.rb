class Cart::Decreaser < CartService

  def serve
    if current_cart.has_key?(@id)
      current_cart[@id]['num'] -= 1 if current_cart[@id]['num'] > 0
    end
  end

end
