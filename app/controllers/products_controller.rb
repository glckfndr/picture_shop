class ProductsController < ApplicationController
  def index
    @products = collection
    @session_products = CartManager::SessionSupplier.call session
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
      redirect_to product_path(@product), notice: "Product #{@product.name} was created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    return unless params[:action_type] == 'add' || params[:action_type] == 'remove'

    attributes = resource.attributes
    case params[:action_type]
    when 'add'
      CartManager::Adder.call(session, attributes)
      notice_text = "Product #{attributes['name']} was added to cart!"
    when 'remove'
      CartManager::Remover.call(session, attributes)
      notice_text = "Product #{attributes['name']} was removed from cart!"
    end
    redirect_to products_path, notice: notice_text
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
end
