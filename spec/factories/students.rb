FactoryBot.define do
  factory :student do
    email { "student@example.com" }
    passcode { "securepasscode" }
    name { "John Doe" }
    text { "Sample text about the student." }
  end
end
