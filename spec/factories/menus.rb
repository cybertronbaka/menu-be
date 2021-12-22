FactoryBot.define do
  factory :menu do
    name { Faker::Name.first_name }
    description { Faker::Quote.famous_last_words }
    user { nil }
  end
end
