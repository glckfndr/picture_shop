class ProductsController < ApplicationController
  def index
    @products = collection

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
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def update
    @product = resource
    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
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
