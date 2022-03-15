FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number:40) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.png')) }
    description { Faker::Lorem.characters(number:1000) }
    category_id { Faker::Number.between(from: 2, to: 11)}
    condition_id { Faker::Number.between(from: 2, to: 7)}
    shipping_fee_id { Faker::Number.between(from: 2, to: 3)}
    prefecture_id { Faker::Number.between(from: 2, to: 48)}
    shipping_schedule_id { Faker::Number.between(from: 2, to: 4)}
    price { Faker::Number.between(from: 300, to: 9999999)}
    association :user
  end
end
