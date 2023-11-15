class StudentsController < ApplicationController
  before_action :require_student, only: [:profile]

  def profile
    @student = current_student
    @created_posts = @student.posts
    @applied_posts = @student.attended_posts
    @time_slots = TimeSlot.where(student: session[:student_id])
  end
end
