class Post < ApplicationRecord
    belongs_to :creator, class_name: "Student"
    has_many :student_attend_posts
    has_many :students, through: :student_attend_posts
    enum status: { open: 0, full: 1, closed: 2 }
  
    def is_full?
        students.count >= capacity
    end
  
    def update_status
        self.status = is_full? ? 'full' : 'open'
        save
    end
end
  