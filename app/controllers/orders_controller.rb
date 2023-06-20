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
      Cart::OrderCreator.serve session, @order.attributes
      redirect_to order_path(@order), notice: "Order for #{@order.first_name} crteated!"
    else
      @session_products = Cart::Supplier.serve session
      @sum = Cart::Summator.serve session
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @order = resource
    if @order.update order_params
      redirect_to order_path(@order), notice: "Order for #{@order.first_name} updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order = resource
    @order.destroy
    redirect_to orders_path, notice: "Order for #{@order.first_name} destroyed!"
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
