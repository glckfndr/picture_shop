class Cart::Cleaner < CartService

  def serve
    @session[:cart] = nil
  end

end
