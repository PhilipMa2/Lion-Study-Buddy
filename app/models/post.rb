class Post < ApplicationRecord
    belongs_to :creator, class_name: "Student", foreign_key: 'creator_id'
    has_many :student_attend_posts
    has_many :students, through: :student_attend_posts
    
    validates :course, presence: true
    validates :tag, presence: true
    validates :text, presence: true
    validates :capacity, presence: true
end
  