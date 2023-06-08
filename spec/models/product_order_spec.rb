require 'rails_helper'

RSpec.describe ProductOrder, type: :model do
  describe "validation of greater than zero" do
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'validation of associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end
end
