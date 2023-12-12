class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_student, :logged_in?, :number_of_overlapping_time_slots

  # private

  def current_student
    @current_student ||= Student.find(session[:student_id]) if session[:student_id]
  end

  def logged_in?
    !!current_student
  end

  def require_student
    unless logged_in?
      redirect_to login_path, notice: "Please log in."
    end
  end

  def number_of_overlapping_time_slots(applicant_student, students)
    return 0 if students.empty?

    overlapping_time_slots = students.reduce(applicant_student.time_slots.pluck(:available_time)) do |result, student|
      result & student.time_slots.pluck(:available_time)
    end

    overlapping_time_slots.count
  end
end
