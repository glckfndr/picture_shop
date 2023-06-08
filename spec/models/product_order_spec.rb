require 'rails_helper'

RSpec.describe ProductOrder, type: :model do
  describe "validation of greater than zero" do
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe 'validation of associations' do
    it { should belong_to(:order)}
    it { should belong_to(:product)}
  end
end
