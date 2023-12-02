class StudentsController < ApplicationController
  before_action :require_student, only: [:profile, :edit, :update]

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      redirect_to profile_path(@student), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def show
    @student = Student.find(params[:id])
    @can_view_full_profile = logged_in? && can_view_full_profile?(@student)
  end

  def can_view_full_profile?(student)
    # Check if the current student has accepted an application from the viewed student
    accepted_by_current_student = Application.where(student_id: student.id, group_id: current_student.groups.select(:id), application_status: 'accepted').exists?
    # Check if the viewed student has accepted an application from the current student
    accepted_by_viewed_student = Application.where(student_id: current_student.id, group_id: student.groups.select(:id), application_status: 'accepted').exists?
    
    # Early return for response rate optimization
    if (accepted_by_current_student || accepted_by_viewed_student)
      return true;
    end

    # Check if the viewed student and the current student share a group they're both accepted to
    current_student_accepted_groups = Application.where(student_id: student.id, application_status: 'accepted')
    # viewed_student_accepted_groups = Application.where(student_id: current_student.id, application_status: 'accepted')

    for current_student_accepted_group in current_student_accepted_groups do
      if (Application.where(student_id: current_student.id, group_id: current_student_accepted_group.group_id, application_status: 'accepted').exists?) 
        # viewed student shares a same accepted group as viewing student
        return true;
      end
    end

    return false;
  end

  def profile
    @student = current_student
    @time_slots = TimeSlot.where(student: session[:student_id])
  end

  # creating new user
  def create_account
    # first check if the information posted is valid
    existing_student = Student.find_by(email: params[:email])
    if existing_student
      flash.now[:notice] = 'An account with this email already exists. Please log in.'
    elsif params[:password] != params[:password_confirmation] 
      flash.now[:notice] = 'Please make sure your password entries match.'
    else
      # after the checks, we know at this point the information is posted by user
      # is sufficient to create a new student in our database.
      @student = Student.new(
        email: params[:email], 
        passcode: params[:password], 
        name: params[:name], 
        course: "", 
        schedule: "", 
        tag: "", 
        text: ""
      )
      if @student.save
        redirect_to login_path, notice: 'Account successfully created. Please log in.'
        return
      else
        flash.now[:notice] = 'Account could not be created. Please try again later.'
      end
    end
    render 'sessions/create_account'
    
   private
    def student_params
      params.require(:student).permit(:name, :email, :course, :schedule, :focus, :text)
    end
end
