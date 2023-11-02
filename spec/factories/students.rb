FactoryBot.define do
    factory :student do
      email { "frank@example.com" }
      passcode { "frank789" }
      name { "Frank" }
      course { "Biology" }
      schedule { "Mon-Wed-Fri 2PM-4PM" }
      tag { "Junior" }
      text { "Researching on marine life" }
    end
end