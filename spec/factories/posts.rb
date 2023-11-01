FactoryBot.define do
    factory :post do
      creator { create(:student) }
      course { "Math 101" }
      start_slot { 1 }
      end_slot { 2 }
      tag { "math" }
      text { "Some details about the post" }
    end
  end