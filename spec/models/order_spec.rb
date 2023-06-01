require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.create(:order) }
  let(:empty_order) { Order.new }
  let!(:product_orders) { FactoryBot.create_list(:product_order, 5, order: order) }

  context 'associations' do
    it 'has many product_orders' do
      association = described_class.reflect_on_association(:product_orders)
      expect(association.macro).to eq(:has_many)
    end

    it 'creates the associated product_orders' do
      expect(order.product_orders.count).to eq(5)
    end

    it 'destroys associated product_orders' do
      expect { order.destroy }.to change(ProductOrder, :count).by(-5)
    end
  end

  context  "positive validation" do
    it "is valid with a firstname, lastname, address, and phone" do
      expect(order).to be_valid
    end
  end

  context  "negative validation" do
    it "is not valid without a firstname" do
      order.first_name = nil
      expect(order).to_not be_valid
    end

    it "is not valid without a lastname" do
      order.last_name = nil
      expect(order).to_not be_valid
    end

    it "is not valid without an address" do
      order.address = nil
      expect(order).to_not be_valid
    end

    it "is not valid without a phone" do
      order.phone = nil
      expect(order).to_not be_valid
    end

    it "is not valid when empty" do
      expect(empty_order).to_not be_valid
    end
  end
end
