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
end
