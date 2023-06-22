class CartService

  def initialize(session, product = nil)
    @session = session
    return if product.nil?
    @id = product["id"].to_s
    @balance = product["balance"].to_i
  end

  def self.serve(*args, &block)
    new(*args, &block).serve
  end

  private

  def current_cart
    @session[:cart] ||= {}
  end
end
