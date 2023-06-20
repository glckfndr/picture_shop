require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let!(:product) { create(:product) }
  let!(:product2) { create(:product) }

  describe "POST #update" do
    context 'adding products to session:' do
      it 'add the same product two times and get sum' do
        post add_to_cart_path(product), params: { product_id: product.id }
        expect(response).to have_http_status(:redirect)
        post plus_path(product), params: { product_id: product.id }
        expect(response).to have_http_status(:redirect)
        expect(session[:cart]["#{product.id}"]).to eq({'num'=> 2, 'balance' => product.balance})
        expect(Cart::Summator.serve session).to eq(product.price * 2)
      end

      it 'add different two products and get sum' do
        post add_to_cart_path(product), params: { product_id: product.id }
        post plus_path(product2), params: { product_id: product2.id }
        expect(Cart::Summator.serve session).to eq(product.price + product2.price)
      end
    end
  end
end
