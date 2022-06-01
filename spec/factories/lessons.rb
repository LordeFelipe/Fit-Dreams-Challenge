FactoryBot.define do
  factory :lesson do
    name { Faker::Lorem.unique.word }
    description { Faker::Lorem.unique.sentence }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    duration { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    association :category
  end
end
