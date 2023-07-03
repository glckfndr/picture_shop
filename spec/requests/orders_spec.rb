shared_context 'order is not in db' do
  let(:product) { create(:product) }
  let(:valid_attributes) { { order: attributes_for(:order) } }
  let(:invalid_attributes) { { order: attributes_for(:order, :invalid_order) } }
  before { post add_product_path(product) }
end

shared_context 'orders are in db' do
  let!(:order) { create(:order) }
  let!(:orders) { create_list(:order, 4) }
end

describe 'Order:', type: :request do
  let(:order) { build(:order) }
  context 'orders are in db' do
    include_context 'orders are in db'
    describe 'GET #index' do
      it 'contains the orders' do
        get orders_path

        expect(response).to be_successful
        expect(response).to render_template(:index)
        orders.each { |order| expect(response.body).to include(order.first_name, order.last_name) }
      end
    end

    describe 'GET #show' do
      it 'returns the order' do
        get order_path(order)

        expect(response).to be_successful
        expect(response).to render_template(:show)
        expect(response.body).to include(order.first_name, order.last_name)
      end
    end
  end

  context 'order is not in db' do
    include_context 'order is not in db'

    describe 'GET #new' do
      it 'sets products and initializes a new order' do
        get new_order_path

        expect(response).to be_successful
        expect(response).to render_template(:new)
      end
    end

    describe 'PATCH #update' do
      context 'with valid order params' do
        it 'creates a new order, calls Orders::ManagerService, and redirects to order page' do
          expect { post orders_path, params: { order: valid_attributes[:order] } }.to change(Order, :count).by(1)

          expect(response).to redirect_to(order_path(Order.last))
          expect(flash[:notice]).to eq("Order for #{Order.last.first_name} was created!")
          expect(session[:products]).to be_nil
        end
      end

      context 'with invalid order params' do
        it 'renders the new template with unprocessable entity status' do
          post orders_path, params: { order: invalid_attributes[:order] }

          expect(response).to be_unprocessable
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
