FactoryBot.define do
  factory :time_slot do
    available_time { 1 }
    student { create(:student) }
  end
end
