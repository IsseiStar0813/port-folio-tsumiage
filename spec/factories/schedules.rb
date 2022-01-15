FactoryBot.define do
  factory :schedule do
    task { Faker::Lorem.characters(number: 10) }
    hours {1}
    start {"10:00:00"}
    finish {"11:00:00"}
  end
end
