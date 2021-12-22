FactoryBot.define do
  factory :section do
    name { Faker::Name.first_name }
    rank { 1 }
    menu { nil }
  end
end
