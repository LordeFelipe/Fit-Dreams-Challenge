FactoryBot.define do
  factory :role do
    factory :student do
      name { 'student' }
    end
    factory :teacher do
      name { 'teacher' }
    end
    factory :admin do
      name { 'admin' }
    end 
  end
end
