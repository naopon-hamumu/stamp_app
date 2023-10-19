FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag#{n}" }
    association :stamp_rally
  end
end
