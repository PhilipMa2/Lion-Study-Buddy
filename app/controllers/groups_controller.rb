class GroupsController < ApplicationController
  before_action :require_student, only: [:new, :create, :apply, :accept_application, :reject_application, :close]

  def show
    @group = Group.find(params[:id])
    attending_students = [@group.creator_id] + @group.applications.where(application_status: 'accepted').pluck(:student_id)
    all_time_slots = attending_students.map do |student_id|
      TimeSlot.where(student_id: student_id).pluck(:available_time)
    end

    @common_time_slots = all_time_slots.reduce { |intersection, time_slots| intersection & time_slots }
    @current_student_time_slots = TimeSlot.where(student: session[:student_id])
  end

  def new
    @group = Group.new
    @student = current_student
  end

  def create
    @group = Group.new(group_params)
    @group.creator = current_student
    @student = current_student
    
    # If course is a course_id, append the corresponding course_name
    if Course.exists?(course_id: @group.course)
      course_name = Course.find_by(course_id: @group.course)&.course_name
      @group.course += " #{course_name}" if course_name
    end

    # check for edge case of capacity = 1
    if @group.capacity == 1
      @group.update(group_status: 'full')
    end

    if @group.save
      redirect_to root_path, notice: 'Group was successfully created.'
    else
      render :new
    end
    # end
  end

  def apply
    @group = Group.find(params[:id])
    @student = current_student
    already_attended = Application.exists?(student: @student, group: @group)

    if @group.creator_id == @student.id
      flash[:alert] = 'You cannot request to join your own group.'
    elsif @group.group_status == "close" || @group.group_status == "full"
      flash[:alert] = 'This group is not accepting applications.'
    elsif already_attended
      flash[:notice] = 'You have already applied to this group!'
    elsif @group.group_status == 'full'
      flash[:alert] = 'This group cannot take any more students.'
    else
      Application.create(student: @student, group: @group)
      flash[:notice] = 'Application submitted!'
    end

    redirect_to group_path(@group)
  end


  def accept_application
    # the form accepts applicant and group as parameters;
    # group_id therefore needs to be passed in from form as well,
    # because params[:id] is overwritten by applicant (first param) id
    group_id = params[:id]
    @group = Group.find(group_id)

    if @group.group_status == 'full'
      redirect_back(fallback_location: root_path, notice: 'Study group is already at max capacity.')
    else 
      application = Application.find(params[:id])
      application.update(application_status: 'accepted')

      # +1 = the creator themself
      accepted_members_count = @group.applications.where(application_status: 'accepted').count + 1

      # whenever accepted, we make sure group status is now full. 
      if @group.capacity <= accepted_members_count
        @group.update(group_status: 'full')
      end
      redirect_to group_path(application.group), notice: 'Application accepted.'
    end
  end

  def reject_application
    application = Application.find(params[:id])
    application.update(application_status: 'rejected')
    redirect_to group_path(application.group), notice: 'Application rejected.'
  end

  def close
    @group = Group.find(params[:id])
    Application.where(group_id: @group.id).destroy_all
    @group.destroy
    redirect_to root_path, notice: 'Group and all associated applications were successfully deleted.'
  end


  private
  
  def group_params
    params.require(:group).permit(:creator_id, :course, :capacity, :focus, :text, :group_status)
  end
end
