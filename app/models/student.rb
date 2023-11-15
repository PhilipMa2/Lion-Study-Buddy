class Student < ApplicationRecord
    def self.authenticate(email, passcode)
        student = find_by(email: email)
        return student if student && student.passcode == passcode
        nil
    end
    has_many :posts, foreign_key: "creator_id"
    has_many :student_attend_posts
    has_many :attended_posts, through: :student_attend_posts, source: :post
    has_many :time_slots, dependent: :destroy, foreign_key: "student"

    def selected_time_slots
        time_slots.pluck(:available_time)
    end
end