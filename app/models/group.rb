class Group < ApplicationRecord
    belongs_to :creator, class_name: "Student", foreign_key: 'creator_id'
    has_many :applications
    has_many :students, through: :applications
    
    validates :course, presence: true
    validates :focus, presence: true
    validates :text, presence: true
    validates :capacity, presence: true
end
  