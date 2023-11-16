FactoryBot.define do
  factory :post do
    association :creator, factory: :student
    course { "Sample Course" }
    capacity { 30 }
    tag { "Sample Tag" }
    text { "Sample text describing the post." }
    post_status { "open" }
  end
end
