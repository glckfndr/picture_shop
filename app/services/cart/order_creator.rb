class Cart::OrderCreator < CartService

  def serve
    return 0 if current_cart.empty?
    current_cart.each do |key, val|
      ProductOrder.create(amount: val , product_id: key.to_i, order_id: @id.to_i)
    end
  end

end
