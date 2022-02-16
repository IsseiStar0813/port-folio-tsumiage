FactoryBot.define do
  factory :schedule do
    task { Faker::Lorem.characters(number: 10) }
    start {"10:00:00"}
    finish {"11:00:00"}
    start_time{"2022-01-01"}
    total_hours {1}
    total_minutes {30}
  end
end
