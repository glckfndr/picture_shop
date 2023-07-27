class CartsController < ApplicationController
  def update
    "CartManager::#{params[:action_type].classify}".constantize.call(session, attributes)
    redirect_to cart_path, notice: "Product is #{params[:action_type] == 'Adder' ? 'added to' : 'removed from'} cart!"
  end

  def show
    @session_products = CartManager::SessionSupplier.call(session)
  end

  def empty
    CartService.clean session

    redirect_to cart_path, notice: 'Cart is emptied!'
  end

  private

  def attributes
    Product.find(params[:id]).attributes
  end
end
