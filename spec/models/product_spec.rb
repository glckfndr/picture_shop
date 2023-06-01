require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.create(:product) }
  let(:empty_product) { Product.new }
  let!(:product_orders) { FactoryBot.create_list(:product_order, 3, product: product) }

  context 'associations' do
    it 'has many product_orders' do
      association = described_class.reflect_on_association(:product_orders)
      expect(association.macro).to eq(:has_many)
    end

    it 'creates the associated product_orders' do
      expect(product.product_orders.count).to eq(3)
    end

    it 'destroys associated product_orders' do
      expect { product.destroy }.to change(ProductOrder, :count).by(-3)
    end
  end

  context  "positive validation" do
    it "is valid with a valid name, price and balance" do
      expect(product).to be_valid
    end

    it "is valid with a valid name, price and balance = 0" do
      product.balance  =  0
      expect(product).to be_valid
    end

    it "is valid with a valid name, balance and  price = 0.0 and" do
      product.price  =  0.0
      expect(product).to be_valid
    end
  end

  context  "negative validation" do
    it "is not valid when empty" do
      expect(empty_product).to_not be_valid
    end

    it "is not valid without a name" do
      product.name = nil
      expect(product).to_not be_valid
    end

    it "is not valid without a price" do
      product.price = nil
      expect(product).to_not be_valid
    end

    it 'is invalid with a negative price' do
      product.price = -5.66
      expect(product).to_not be_valid
      expect(product.errors[:price]).to include("must be greater than or equal to 0")
    end

    it 'is invalid with a negative balance' do
      product.balance = - 1
      expect(product).to_not be_valid
      expect(product.errors[:balance]).to include("must be greater than or equal to 0")
    end
  end
end
