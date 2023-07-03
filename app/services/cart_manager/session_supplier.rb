class CartManager::SessionSupplier < CartService
  def serve
    ids = current_cart.keys.map(&:to_i)
    products = Product.find(ids).inject([]) do |products, product|
      quantity = current_cart[product.id.to_s]
      products.append OpenStruct.new(
        name: product.name,
        price: product.price,
        quantity: quantity['amount'],
        sum: quantity['amount'] * product.price,
        id: product.id
      )
    end

    {
      products:,
      total_sum: products.inject(0) { |total, product| total + product.sum }
    }
  end
end
