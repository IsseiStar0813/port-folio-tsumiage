FactoryBot.define do
  factory :answer do
    content { Faker::Lorem.characters(number: 10)  }
  end
end
