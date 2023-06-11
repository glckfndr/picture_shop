FactoryBot.define do
  factory :product_order do
    association :product, factory: :product
    association :order, factory: :order
    amount { Faker::Number.within(range: 1..7) }
  end
end
