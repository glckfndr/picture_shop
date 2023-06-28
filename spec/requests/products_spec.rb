shared_context 'product is not in db' do
  let(:product) { build(:product) }
end

shared_context 'products are in db' do
  let!(:products) { create_list(:product, 4) }
  let!(:product) { create(:product) }
end

describe 'ProductsController', type: :request do
  context 'products are in db' do
    include_context 'products are in db'
    describe 'GET /products' do
      it 'contains the product names and price' do
        get products_path

        expect(response).to render_template(:index)
        expect(response).to be_successful
        products.each { |product|  expect(response.body).to include(product.name, product.price.to_s) }
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get product_path(product)

        expect(response).to render_template(:show)
        expect(response).to be_successful
        expect(response.body).to include(product.name, product.price.to_s)
      end
    end

    describe 'DELETE /destroy' do
      it 'deletes the product' do
        expect { delete product_path(product) }.to change(Product, :count).by(-1)
      end

      it 'redirects to the products index' do
        delete product_path(product)

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe 'POST /products' do
    context 'product is not in db' do
      include_context 'product is not in db'
      it 'creates a new product' do
        expect { post products_path, params: { product: product.attributes } }.to change(Product, :count).by(1)
      end

      it 'returns a created response' do
        post products_path, params: { product: product.attributes }

        expect(response).to have_http_status(:redirect)
      end

      it 'returns the created product' do
        post products_path, params: { product: product.attributes }

        expect(response).to redirect_to(product_path(Product.last))
        expect(flash[:notice]).to eq("Product #{product.name} was created!")
        expect(response.body).to include(Product.last.id.to_s)
      end
    end
  end
end
