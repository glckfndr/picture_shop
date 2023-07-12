class CartManager::SessionSupplier < CartService
  def serve
    {
      products: products_info,
      total_sum: products_info.inject(0) { |total, product| total + product.amount_sum }
    }
  end

  private

  ProductInfo = Struct.new(:name, :price, :quantity, :amount_sum, :id)

  def products_info
    ids = current_cart.keys.map(&:to_i)
    Product.find(ids).inject([]) do |products, product|
      quantity = current_cart[product.id.to_s]
      products.append ProductInfo.new(product.name, product.price,
                                      quantity['amount'], quantity['amount'] * product.price,
                                      product.id)
    end
  end
end
