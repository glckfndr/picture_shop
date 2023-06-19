# t.string "name", null: false
#t.text "description"
#t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
#t.integer "balance", default: 0, null: false
#t.datetime "created_at", null: false
#t.datetime "updated_at", null: false

#class Product < ApplicationRecord
#  has_many :product_orders, dependent: :destroy
#  has_many :orders, through: :product_orders
#  validates :name, presence: true
#  validates :price, :balance, numericality: { greater_than_or_equal_to: 0 }
#end

#   resources :products

require 'rails_helper'

RSpec.describe "Products", type: :request do
  let!(:product) { create(:product) }

  describe "GET /products" do
     let!(:products) {create_list(:product, 4) }
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

  describe "GET /new" do
    it "renders a successful response" do
      get new_product_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      get edit_product_path(product)
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH /update" do

    it 'permits the correct parameters' do
      patch product_path(product), params: { product: { name: 'Updated Product' } }
      expect(response).to have_http_status(:redirect)
      expect(product.reload.name).to eq('Updated Product')
    end

    it 'redirects to the product page' do
      patch product_path(product), params: { product: { name: 'Updated Product' } }
      expect(response).to redirect_to(product)
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

    context "with invalid parameters" do
      let(:invalid_params) {{product: { name: "", price: -1 }} }

      it "does not create a new product" do
        expect {post products_path, params: invalid_params}.not_to change(Product, :count)
      end

      it "returns an unprocessable entity response" do
        post products_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the validation errors" do
        post products_path, params: invalid_params
        expect(response.body).to include(CGI.escapeHTML("can't be blank"))
        expect(response.body).to include("must be greater than or equal to 0")
      end
    end
  end
end
