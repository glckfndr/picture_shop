class CartService

  def initialize session, id = nil
    @session = session
    @id = id
  end

  def self.serve(*args, &block)
    new(*args, &block).serve
  end

  private
  def current_cart
    @session[:cart] ||= {}
  end

end
