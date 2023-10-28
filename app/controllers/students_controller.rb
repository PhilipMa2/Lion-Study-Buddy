class StudentsController < ApplicationController
  before_action :require_student, only: [:profile]

  def profile
    @student = current_student
  end
end
