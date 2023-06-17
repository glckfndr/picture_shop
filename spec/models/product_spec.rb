require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validation of precense" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "validations of greater than zero" do
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
  end

  describe 'validations of associations to product_orders' do
    it { is_expected.to have_many(:orders).through(:product_orders) }
    it { is_expected.to have_many(:product_orders).dependent(:destroy) }
  end
end
