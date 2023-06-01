FactoryBot.define do
  factory :product_order do
    amount { 1 }
    product { nil }
    order { nil }
  end
end
