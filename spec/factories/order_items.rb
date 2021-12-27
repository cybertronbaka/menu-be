FactoryBot.define do
  factory :order_item do
    order { nil }
    item { nil }
    quantity { 1 }

    trait :pending do
      status { 'pending' }
    end

    trait :served do
      status { 'served' }
    end
  end
end
