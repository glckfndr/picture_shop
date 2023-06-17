module CartsHelper

  def cart
    cart_products = Product.find(current_cart)
  end
end
