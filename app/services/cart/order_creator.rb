class Cart::OrderCreator < CartService
  def serve
    return nil if current_cart.empty?
    current_cart.each do |key, data|
      ProductOrder.create(amount: data["amount"], product_id: key, order_id: @id.to_i)
    end
  end
end
