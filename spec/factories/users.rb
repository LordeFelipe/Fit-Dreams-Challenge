FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 80) }
    email { Faker::Internet.unique.email }
    password { '123456' }

    factory :student do
      association :role, factory: :student_role
    end

    factory :teacher do
      association :role, factory: :teacher_role
    end

    factory :admin do
      association :role, factory: :admin_role
    end
  end
end
