FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "tester#{n}" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
  end
end
