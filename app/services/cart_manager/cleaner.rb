class CartManager::Cleaner < CartService
  def serve
    @session[:cart] = nil
  end
end
