class CartService
  def initialize(session, product = nil)
    @session = session
    return if product.nil?

    @id = product['id'].to_s
    @balance = product['balance']
    @price = product['price']
  end

  def self.call(*args)
    new(*args).call
  end

  def self.clean session
    session[:cart] = nil
  end

  private

  def current_cart
    @session[:cart] ||= {}
  end
end
