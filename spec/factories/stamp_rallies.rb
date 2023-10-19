FactoryBot.define do
  factory :stamp_rally do
    sequence(:title) { |n| "StampRally #{n}" }
    description { 'Sample stamp rally for testing purposes' }
    association :user
    stamps_attributes { [FactoryBot.attributes_for(:stamp)] }

    trait :public_open do
      visibility { :public_open }
    end

    trait :with_image do
      image { Rack::Test::UploadedFile.new( \
        "#{Rails.root}/spec/files/fuma.jpeg", "image/jpeg") }
    end

    trait :without_title do
      title { nil }
    end

    trait :without_stamp_name do
      stamps_attributes { [FactoryBot.attributes_for(:stamp, :without_name)] }
    end

    trait :without_stamp_sticker do
      stamps_attributes { [FactoryBot.attributes_for(:stamp, :without_sticker)] }
    end

    trait :without_stamp_location do
      stamps_attributes { [FactoryBot.attributes_for(:stamp, :without_location)] }
    end
  end
end
