FactoryBot.define do
  factory :product do
    name { Faker::Creature::Dog.name }
    price { Faker::Number.between(from: 20.0, to: 1000.0) }
    balance { Faker::Number.within(range: 1..10) }
  end

  trait :invalid_product do
    name { nil }
    description { nil }
    price { -1 }
    balance { -999 }
  end
end
