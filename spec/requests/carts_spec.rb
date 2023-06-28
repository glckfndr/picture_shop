shared_context 'cart has a product' do
  before { post add_product_path(product) }
  after { delete empty_path }
end

describe 'CartsController', type: :request do
  let(:product) { create(:product) }

  context 'cart is empty' do
    it 'add one product to cart' do
      post add_product_path(product)

      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eq("Product #{product.name} was added to cart!")
      expect(session[:cart][product.id.to_s]).to eq({ 'amount' => 1, 'balance' => product.balance })
    end

    context 'cart has a product' do
      include_context 'cart has a product'

      it 'clean cart' do
        delete empty_path

        expect(response).to have_http_status(:redirect)
        expect(session[:cart]).to be_nil
      end

      it 'plus product' do
        post plus_product_to_carts_path(id: product.id)

        expect(response).to have_http_status(:redirect)
        expect(session[:cart][product.id.to_s]).to eq({ 'amount' => 2, 'balance' => product.balance })
        expect(CartManager::Summator.serve(session)).to eq(2 * product.price)
      end

      it 'minus product' do
        post minus_product_to_carts_path(id: product.id)

        expect(response).to have_http_status(:redirect)
        expect(session[:cart][product.id.to_s]).to eq({ 'amount' => 0, 'balance' => product.balance })
        expect(CartManager::Summator.serve(session)).to eq(0)
      end

      it 'delete product' do
        post del_product_to_carts_path(id: product.id)

        expect(response).to have_http_status(:redirect)
        expect(session[:cart][product.id.to_s]).to be_nil
      end

      it 'remove product' do
        post remove_product_path(product)

        expect(response).to have_http_status(:redirect)
        expect(session[:cart][product.id.to_s]).to be_nil
      end

      it 'show cart' do
        get carts_path

        expect(response).to render_template(:show)
        expect(response).to be_successful
        expect(response.body).to include(product.name)
        expect(response.body).to include(product.price.to_s)
      end
    end
  end
end
