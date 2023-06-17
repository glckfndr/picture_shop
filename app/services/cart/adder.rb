class Cart::Adder < CartService

  def serve
    if current_cart.has_key?(@id)
      current_cart[@id] += 1
    else
     current_cart[@id] = 1
    end
  end

end
