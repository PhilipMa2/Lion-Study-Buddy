class StudentAttendPost < ApplicationRecord
    belongs_to :student
    belongs_to :post
    enum status: { applied: 0, accepted: 1, rejected: 2 }
end
  