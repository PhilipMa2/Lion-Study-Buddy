FactoryBot.define do
    factory :post do
      creator { create(:student) }
      course { "Math 101" }
      schedule { "MWF 10:00-11:00" }
      tag { "math" }
      text { "Some details about the post" }
    end
  end