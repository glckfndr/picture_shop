class CartsController < ApplicationController

  def update
    product_name = Product.find(params[:product_id]).name
    Cart::Adder.serve(session, params[:product_id])
    redirect_to products_path, notice: "Product #{product_name} added to cart!"
  end

  def show
    @session_products = Cart::Supplier.serve session
    @sum = Cart::Summator.serve session
  end

  def create
  end

  def delete
    product_name = Product.find(params[:product_id]).name
    Cart::Remover.serve(session, params[:product_id])
    redirect_to products_path, notice: "Product #{product_name} removed from cart!"
  end

  def plus
    Cart::Adder.serve(session, params[:product_id])
    redirect_to cart_path
  end

  def minus
    Cart::Decreaser.serve(session, params[:product_id])
    redirect_to cart_path
  end

  def del
    Cart::Remover.serve(session, params[:product_id])
    redirect_to cart_path
  end

  def empty
    Cart::Cleaner.serve session
    redirect_to cart_path
  end
end
