class Student < ApplicationRecord
    def self.authenticate(email, passcode)
        student = find_by(email: email)
        return student if student && student.passcode == passcode
        nil
    end
    has_many :posts, foreign_key: "creator_id"
    has_many :students_attend_posts
    has_many :attended_posts, through: :students_attend_posts, source: :post
end