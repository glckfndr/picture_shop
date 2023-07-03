class CartsController < ApplicationController
  def update
    "CartManager::#{params[:action_type].classify}".constantize.serve(session, attributes)
    redirect_to cart_path
  end

  def show
    @session_products = CartManager::SessionSupplier.serve(session)
  end

  def empty
    CartManager::Cleaner.serve session

    redirect_to cart_path
  end

  private

  def attributes
    Product.find(params[:id]).attributes
  end
end
