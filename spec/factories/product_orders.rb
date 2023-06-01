FactoryBot.define do
  factory :product_order do
    association :product, factory: :product
    association :order, factory: :order
    amount { 1 }
  end
end
