class ProductsController < ApplicationController
  def index
    @products = collection
    @session_products = CartManager::Supplier.serve session
    @sum = CartManager::Summator.serve session
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
    case params[:action_type]
    when 'add'
      CartManager::Adder.serve(session, attributes)

      redirect_to products_path, notice: "Product #{attributes['name']} added to cart!"
    when "remove"
      CartManager::Remover.serve(session, attributes)

      redirect_to products_path, notice: "Product #{attributes['name']} removed from cart!"
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
    Product.all.ordered
  end

  def resource
    collection.find(params[:id])
  end

  def attributes
    Product.find(params[:id]).attributes
  end
end
