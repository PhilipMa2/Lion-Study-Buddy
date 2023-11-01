class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_student, :logged_in?

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

end
