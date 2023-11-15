class StudentsController < ApplicationController
  before_action :require_student, only: [:profile]

  def show
    @student = Student.find(params[:id])
    @can_view_full_profile = logged_in? && can_view_full_profile?(@student)
  end

  def can_view_full_profile?(student)
    # Check if the current student has accepted an application from the viewed student
    accepted_by_current_student = StudentAttendPost.where(student_id: student.id, post_id: current_student.posts.select(:id), apply_status: 'accepted').exists?
    # Check if the viewed student has accepted an application from the current student
    accepted_by_viewed_student = StudentAttendPost.where(student_id: current_student.id, post_id: student.posts.select(:id), apply_status: 'accepted').exists?
    
    accepted_by_current_student || accepted_by_viewed_student
  end

  def profile
    @student = current_student
    @created_posts = @student.posts
    @applied_posts = @student.applied_posts_with_status
  end
end
