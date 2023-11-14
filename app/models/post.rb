class Post < ApplicationRecord
    belongs_to :creator, class_name: "Student", foreign_key: 'creator_id'
    has_many :student_attend_posts
    has_many :students, through: :student_attend_posts
  
    # def is_full?
    #     students.count >= capacity
    # end
  
    # def update_status
    #     self.poststatus = is_full? ? 'full' : 'open'
    #     save
    # end
end
  