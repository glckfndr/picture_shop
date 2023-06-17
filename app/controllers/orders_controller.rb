class OrdersController < ApplicationController
  def index
    @orders = collection
  end

  def show
    @order = resource
    @session_products = Cart::Supplier.serve session
    @sum = Cart::Summator.serve session
    Cart::Cleaner.serve session
  end

  def new
    @session_products = Cart::Supplier.serve session
    @sum = Cart::Summator.serve session
    @order = Order.new
  end

  def edit
    @order = resource
  end

  def create
    @order = Order.new order_params
    if @order.save
      Cart::OrderCreator.serve session, @order.id
      redirect_to order_path(@order), notice: "Order for #{@order.first_name} crteated!"
    else
      render :new
    end
  end

  def update
    @order = resource
    if @order.update order_params
      redirect_to order_path(@order) , notice: "Order updated!"
    else
      render :edit
    end
  end

  def destroy
    @order = resource
    @order.destroy
    redirect_to orders_path
  end

  private
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
