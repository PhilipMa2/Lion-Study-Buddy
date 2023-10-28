class Post < ApplicationRecord
    belongs_to :creator, class_name: "Student"
    has_many :student_attend_posts
    has_many :students, through: :student_attend_posts
    enum status: { pending: 'pending', confirmed: 'confirmed', cancelled: 'cancelled' }
end