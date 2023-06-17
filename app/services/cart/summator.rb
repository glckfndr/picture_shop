class Cart::Summator < CartService

  def serve
    return 0 if current_cart.empty?
    numbers = current_cart.values
    keys = current_cart.keys.map{|x| x.to_i}
    price = Product.find(keys).map{|x| x.price}
    numbers.zip(price).inject(0) {|sum, x| sum + x[0]*x[1]}
  end

end