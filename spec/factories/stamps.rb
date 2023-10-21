FactoryBot.define do
  factory :stamp do
    association :stamp_rally
    sequence(:name) { |n| "Stamp #{n}" }
    sticker { Rack::Test::UploadedFile.new( \
      "#{Rails.root}/spec/files/fuma.jpeg", "image/jpeg") }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    trait :without_name do
      name { nil }
    end

    trait :without_sticker do
      sticker { nil }
    end

    trait :without_location do
      latitude { nil }
      longitude { nil }
    end
  end
end
