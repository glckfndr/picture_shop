shared_context 'cart has two products' do
  before do
    session[:cart] = { product.id.to_s => { 'amount' => 2, 'balance' => product.balance } }
  end
end

describe 'Service of CartManager' do
  let(:product) { create(:product) }
  let(:session) { {} }
  context 'cart is empty' do
    it 'add product to cart' do
      CartManager::Adder.call(session, product.attributes)
      expect(session[:cart][product.id.to_s]).to eq({ 'amount' => 1, 'balance' => product.balance })
    end
  end

  context 'cart has two products' do
    include_context 'cart has two products'
    it 'get sum of products in cart' do
      expect(CartManager::Summator.call(session)).to eq(2 * product.price)
    end

    it 'minus one product from cart' do
      CartManager::Decreaser.call(session, product.attributes)
      expect(session[:cart][product.id.to_s]['amount']).to eq(1)
    end

    it 'remove product from cart' do
      CartManager::Remover.call(session, product.attributes)
      expect(session[:cart][product.id.to_s]).to be_nil
    end

    it 'clean cart' do
      CartManager::Cleaner.call(session, product.attributes)
      expect(session[:cart]).to be_nil
    end
  end
end
