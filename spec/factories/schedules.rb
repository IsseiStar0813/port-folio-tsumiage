FactoryBot.define do
  factory :schedule do
    task { Faker::Lorem.characters(number: 10) }
    hours {1}
  end
end
