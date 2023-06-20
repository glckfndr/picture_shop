class CartsController < ApplicationController

  def update
    Cart::Adder.serve(session, attributes)
    redirect_to products_path, notice: "Product #{attributes['name']} added to cart!"
  end

  def show
    @session_products = Cart::Supplier.serve session
    @sum = Cart::Summator.serve session
  end

  def create
  end

  def delete
    Cart::Remover.serve(session, attributes)
    redirect_to products_path, notice: "Product #{attributes['name']} removed from cart!"
  end

  def plus
    Cart::Adder.serve(session, attributes)
    redirect_to cart_path
  end

  def minus
    Cart::Decreaser.serve(session, attributes)
    redirect_to cart_path
  end

  def del
    Cart::Remover.serve(session, attributes)
    redirect_to cart_path
  end

  def empty
    Cart::Cleaner.serve session
    redirect_to cart_path
  end

  private

  def attributes
    Product.find(params[:product_id]).attributes
  end

end
