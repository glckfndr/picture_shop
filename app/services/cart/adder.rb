class Cart::Adder < CartService

  def serve
    if current_cart.has_key?(@id)
      current_cart[@id]['num'] += 1 if current_cart[@id]['num'] < current_cart[@id]['balance']
    else
      current_cart[@id] = {'num' => 1, 'balance' => @balance}
    end
  end

end
