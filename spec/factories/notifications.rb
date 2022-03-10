FactoryBot.define do
  factory :notification do
    notification_type { :food_orders }
    body { 'You received an order' }
    link { '/order-details/1' }
    image { nil }
    read { false }
    user { nil }

    trait :read do
      read { true }
    end

    trait :not_read do
      read { false }
    end
  end
end
