class Cart::Supplier < CartService
  def serve
    ids = current_cart.keys.map{|id| id.to_i}
    Product.find(ids).inject([]) do |products, product|
      quantity =  current_cart[product.id.to_s]
      products.append OpenStruct.new(name: product.name,
                                      price: product.price,
                                      quantity: quantity["amount"],
                                      sum: quantity["amount"] * product.price,
                                      id: product.id)
    end
  end
end
