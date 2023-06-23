class CartsController < ApplicationController
  def update
    case params[:action_type]
    when 'plus'
      Cart::Adder.serve(session, attributes)
    when "del"
      Cart::Remover.serve(session, attributes)
    when "minus"
      Cart::Decreaser.serve(session, attributes)
    end

    redirect_to cart_path
  end

  def show
    @session_products = Cart::Supplier.serve(session)
    @sum = Cart::Summator.serve(session)
  end

  def empty
    Cart::Cleaner.serve session

    redirect_to cart_path
  end

  private

  def attributes
    Product.find(params[:id]).attributes
  end
end
