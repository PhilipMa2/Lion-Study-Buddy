FactoryBot.define do
  factory :group do
    association :creator, factory: :student
    course { "Sample Course" }
    capacity { 30 }
    focus { "Sample Focus" }
    text { "Sample text describing the post." }
    group_status { "open" }
  end
end
