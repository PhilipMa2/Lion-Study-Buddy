FactoryBot.define do
  factory :student do
    email { "student@example.com" }
    passcode { "securepasscode" }
    name { "John Doe" }
    course { "Computer Science" }
    schedule { "Sample Schedule" }
    tag { "Sample Tag" }
    text { "Sample text about the student." }
  end
end
