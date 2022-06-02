FactoryBot.define do
  factory :role do
    factory :student_role do
      name { 'student' }
    end

    factory :teacher_role do
      name { 'teacher' }
    end

    factory :admin_role do
      name { 'admin' }
    end
  end
end
