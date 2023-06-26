class CartManager::OrderCreator < CartService
  def serve
    return nil if current_cart.empty?

    current_cart.each do |id, data|
      ProductOrder.create(amount: data['amount'], product_id: id, order_id: @id)
    end
  end
end
