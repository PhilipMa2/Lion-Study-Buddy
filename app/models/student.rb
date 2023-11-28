class Student < ApplicationRecord
    has_many :groups, foreign_key: "creator_id"
    has_many :applications
    has_many :applied_groups, through: :applications, source: :group
    has_many :time_slots, dependent: :destroy, foreign_key: "student"

    def self.authenticate(email, passcode)
        student = find_by(email: email)
        return student if student && student.passcode == passcode
        nil
    end

    # def applied_posts_with_status
    #     StudentAttendPost.includes(:post)
    #         .where(student_id: id)
    # end

    def selected_time_slots
        time_slots.pluck(:available_time)
    end
end