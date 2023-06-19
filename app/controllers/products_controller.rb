class ProductsController < ApplicationController
  def index
    @products = collection
    @session_products = Cart::Supplier.serve session
    @sum = Cart::Summator.serve session

  end

  def show
    @product = resource

  end

  def new
    @product = Product.new
  end

  def edit
    @product = resource
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to product_path(@product), notice: "Product #{@product.name} created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource
    if @product.update product_params
      redirect_to product_path(@product), notice: "Product #{@product.name} updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resource
    @product.destroy
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :balance)
  end

  def collection
    Product.all
  end

  def resource
    collection.find(params[:id])
  end

end
