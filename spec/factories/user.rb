FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    mobile { Faker::PhoneNumber.phone_number }
    role_id { 1 }
    password { 'NyeMenu2021' }

    trait :super_admin do
      role_id { 1 }
    end

    trait :restuarant_owner do
      role_id { 2 }
    end

    after :create do |user|
      user.profile = build :profile, user: user
    end
  end
end
