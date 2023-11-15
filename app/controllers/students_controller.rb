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
    
    # Early return for response rate optimization
    if (accepted_by_current_student || accepted_by_viewed_student)
      return true;
    end

    # Check if the viewed student and the current student share a post they're both accepted to
    current_student_accepted_posts = StudentAttendPost.where(student_id: student.id, apply_status: 'accepted')
    # viewed_student_accepted_posts = StudentAttendPost.where(student_id: current_student.id, apply_status: 'accepted')

    for current_student_accepted_post in current_student_accepted_posts do
      if (StudentAttendPost.where(student_id: current_student.id, post_id: current_student_accepted_post.post_id, apply_status: 'accepted').exists?) 
        # viewed student shares a same accepted post as viewing student
        return true;
      end
    end

    return false;
  end

  def profile
    @student = current_student
    @created_posts = @student.posts
    @applied_posts = @student.applied_posts_with_status
    @time_slots = TimeSlot.where(student: session[:student_id])
  end
end
