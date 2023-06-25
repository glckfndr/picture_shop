require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let!(:product) { create(:product) }
  let!(:product2) { create(:product) }

  describe "POST add(plus) and sum" do
    context 'adding products to session:' do
      it 'add one product to session' do
        post add_product_path(product), params: { action_type: "add" }
        expect(response).to have_http_status(:redirect)
        expect(session[:cart]["#{product.id}"]).to eq({'amount'=> 1, 'balance' => product.balance})
      end

      it 'add the same product two times and get sum' do
        post add_product_path(product), params: { action_type: "add" }
        expect(response).to have_http_status(:redirect)
        post plus_product_to_carts_path(id: product.id)
        expect(response).to have_http_status(:redirect)
        expect(session[:cart]["#{product.id}"]).to eq({'amount'=> 2, 'balance' => product.balance})
        expect(Cart::Summator.serve session).to eq(product.price * 2)
      end

      it 'add different two products and get sum' do
        post add_product_path(product), params: { action_type: "add"  }
        post plus_product_to_carts_path(id: product2.id)
        expect(Cart::Summator.serve session).to eq(product.price + product2.price)
      end

      it 'add different two products and minus last and get sum' do
        post add_product_path(product), params: { action_type: "add" }
        expect(response).to have_http_status(:redirect)
        post plus_product_to_carts_path(id: product2.id), params: { action_type: "plus" }
        expect(response).to have_http_status(:redirect)
        post minus_product_to_carts_path(id: product2.id), params: { action_type: "minus" }
        expect(response).to have_http_status(:redirect)
        expect(Cart::Summator.serve session).to eq(product.price)
      end
    end
  end
end
