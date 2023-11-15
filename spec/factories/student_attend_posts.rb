FactoryBot.define do
  factory :student_attend_post do
    association :student
    association :post
    apply_status { "pending" }
  end
end
