class OrdersController < ApplicationController
  def index
    @orders_products = collection.map(&:order_info)
  end

  def show
    @order = resource

    @products = @order.order_info[:products]
  end

  def new
    @session_products = CartManager::SessionSupplier.serve session
    @order = Order.new
  end

  def edit
    @order = resource
    @order_products = @order.order_info
  end

  def create
    @order = Order.new order_params

    if @order.save
      handle_cart
      redirect_to order_path(@order), notice: "Order for #{@order.first_name} was created!"

    else
      @session_products = CartManager::SessionSupplier.serve session

      render :new, status: :unprocessable_entity
    end
  end

  def update
    @order = resource
    if @order.update order_params
      redirect_to order_path(@order), notice: "Order for #{@order.first_name} was updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order = resource
    @order.restore_balance
    @order.destroy

    redirect_to orders_path, notice: "Order for #{@order.first_name} destroyed!"
  end

  private

  def handle_cart
    CartManager::OrderCreator.serve session, @order.attributes
    CartManager::BalanceDecreaser.serve session
    CartManager::Cleaner.serve session
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :address, :phone)
  end

  def collection
    Order.all
  end

  def resource
    collection.find(params[:id])
  end
end
