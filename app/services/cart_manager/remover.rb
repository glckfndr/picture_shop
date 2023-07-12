class CartManager::Remover < CartService
  def call
    current_cart.delete(@id)
  end
end
