FactoryBot.define do
  factory :student do
    email { "student@example.com" }
    passcode { "securepasscode" }
    name { "John Doe" }
    course { "Computer Science" }
    schedule { "Sample Schedule" }
    focus { "Sample focus" }
    text { "Sample text about the student." }
  end
end
