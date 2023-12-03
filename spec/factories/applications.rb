FactoryBot.define do
  factory :application do
    association :student
    association :group
    application_status { "pending" }
  end
end
