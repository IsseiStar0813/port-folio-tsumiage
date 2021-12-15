FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:5) }
    content { Faker::Lorem.characters(number:20) }
  end
end
