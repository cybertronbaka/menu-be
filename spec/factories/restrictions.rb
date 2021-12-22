FactoryBot.define do
  factory :restriction do
    value { nil }
    user { nil }

    trait :menu_count do
      restriction_type { 'menu_count' }
    end
  end
end
