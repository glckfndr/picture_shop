require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:product) { create(:product) }
  let!(:products) {create_list(:product, 4) }

  describe "GET /products" do
     it "contains the product names" do
        get products_path
        expect(response.body).to include products.first.name
        expect(response.body).to include products.last.name
     end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get product_path(product)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it "returns the requested product" do
      get product_path(product)
      expect(response.body).to include(product.name)
      expect(response.body).to include(product.price.to_s)
    end
  end

  describe "DELETE /destroy" do
    it 'deletes the product' do
      expect {
        delete product_path(product)
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to the products index' do
      delete product_path(product)
      expect(response).to redirect_to(products_path)
    end

    it 'returns a redirect status' do
      delete product_path(product)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "POST /products" do
    context "with valid parameters" do
      let(:valid_params) { {product: attributes_for(:product)} }

      it "creates a new product" do
        expect{post products_path, params: valid_params}.to change(Product, :count).by(1)
      end

      it "returns a created response" do
        post products_path, params: valid_params
        expect(response).to have_http_status(:redirect)
      end

      it "returns the created product" do
        post products_path, params: valid_params
        expect(response).to redirect_to(product_path(Product.last))
        get product_path(Product.last)
        expect(response.body).to include(Product.last.name)
        expect(response.body).to include(Product.last.price.to_s)
      end
    end
  end
end
