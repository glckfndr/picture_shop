require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations of precense" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:phone) }
  end

  describe 'validations of associations' do
    it { should have_many(:products).through(:product_orders) }
    it { should have_many(:product_orders).dependent(:destroy) }
  end
end
