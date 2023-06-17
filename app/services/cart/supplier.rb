class Cart::Supplier < CartService

  def serve
    ids = current_cart.keys.map{|x| x.to_i}
    Product.find(ids).inject([]) do |products, x|
      quantity =  current_cart[x.id.to_s]
      products.append OpenStruct.new(name: x.name, price: x.price, quantity: quantity, sum: quantity * x.price, id: x.id)
    end
  end

end
