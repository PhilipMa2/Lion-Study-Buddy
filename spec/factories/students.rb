FactoryBot.define do
    factory :student do
      email { "student@example.com" }
      passcode { "securepass" }
      name { "John Doe" }
      course { "Math 101" }
      schedule { "MWF 10:00-11:00" }
      tag { "math" }
      text { "Some details about the student" }
    end
end