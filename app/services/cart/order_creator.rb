class Cart::OrderCreator < CartService

  def serve
    return 0 if current_cart.empty?
    current_cart.each do |key, val|
      ProductOrder.create(amount: val , product_id: key, order_id: @id)
    end
  end

end
