class StudentAttendPost < ApplicationRecord
    belongs_to :student
    belongs_to :post
end