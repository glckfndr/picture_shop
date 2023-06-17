class Cart::Remover < CartService

  def serve
    current_cart.delete(@id)
  end

end
