class GroupsController < ApplicationController
  before_action :require_student, only: [:new, :create, :apply, :accept_application, :reject_application, :close]

  def show
    @group = Group.find(params[:id])
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
    accepted_applications_count = @group.applications.where(application_status: 'accepted').count

    if @group.creator_id == @student.id
      flash[:alert] = 'You cannot request to join your own group.'
    elsif @group.group_status == "close" || @group.group_status == "full"
      flash[:alert] = 'This group is not accepting applications.'
    elsif already_attended
      flash[:notice] = 'You have already applied to this group!'
    elsif accepted_applications_count + 1 >= @group.capacity
      flash[:alert] = 'This group has reached its capacity.'
      @group.update(group_status: 'full')
    else
      Application.create(student: @student, group: @group)
      flash[:notice] = 'Application submitted!'
    end

    redirect_to group_path(@group)
  end


  def accept_application
    application = Application.find(params[:id])
    application.update(application_status: 'accepted')
    redirect_to group_path(application.group), notice: 'Application accepted.'
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
