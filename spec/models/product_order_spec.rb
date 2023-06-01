require 'rails_helper'

RSpec.describe ProductOrder, type: :model do
  let(:product) { FactoryBot.create(:product) }
  let(:order) { FactoryBot.create(:order) }
  let(:product_order) { FactoryBot.create(:product_order, product: product, order: order) }

  context 'associations' do
    it 'belongs to a product' do
      expect(product_order.product).to eq(product)
    end

    it 'belongs to an order' do
      expect(product_order.order).to eq(order)
    end
  end

  context  "positive validation" do
    it "is valid with a product, order and amount" do
      expect(product_order).to be_valid
    end
  end

  context  "negative validation" do
    it "is not valid without a product" do
      product_order.product = nil
      expect(product_order).to_not be_valid
    end

    it "is not valid without an order" do
      product_order.order = nil
      expect(product_order).to_not be_valid
    end

    it "is not valid without a amount" do
      product_order.amount = nil
      expect(product_order).to_not be_valid
    end

    it "is not valid with a quantity less than 1" do
      product_order.amount = 0
      expect(product_order).to_not be_valid
    end
  end
end
