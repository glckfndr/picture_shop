class CartManager::Cleaner < CartService
  def call
    @session[:cart] = nil
  end
end
