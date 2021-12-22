FactoryBot.define do
  factory :item do
    name { Faker::Name.first_name }
    description { nil }
    price { 100 }
    pictures { [] }
    rank { nil }
    section { nil }

    trait :available do
      status { 'available' }
    end

    trait :unavailable do
      status { 'unavailable' }
    end
  end
end
