class PostsController < ApplicationController
  before_action :require_student, only: [:new, :create, :attend]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @student = current_student
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_student
    @student = current_student
    
    # overlap_exists = current_student.posts.any? do |post|
    #   new_start, new_end = @post.start_slot, @post.end_slot
    #   existing_start, existing_end = post.start_slot, post.end_slot

    #   new_start < existing_end && existing_start < new_end
    # end

    # if overlap_exists
    #   flash.now[:alert] = 'Error: The schedule overlaps with an existing post.'
    #   redirect_to root_path, notice: 'You already created this post.'
    # else
    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      render :new
    end
    # end
  end

  def apply
    @post = Post.find(params[:id])
    @student = current_student
    already_attended = StudentAttendPost.exists?(student: @student, post: @post)

    if @post.closed? || @post.full?
      flash[:alert] = 'This post is not accepting applications.'
    elsif already_attended
      StudentAttendPost.create(student: @student, post: @post)
      flash[:notice] = 'You already applied this post!'
    else
      StudentAttendPost.create(student: @student, post: @post, status: :applied)
      flash[:notice] = 'Application submitted!'
    end

    redirect_to post_path(@post)
  end

  def accept_application
    application = StudentAttendPost.find(params[:id])
    application.accepted!
    application.post.update_status
    redirect_to post_path(@application.post), notice: 'Application accepted.'
  end

  def reject_application
    @application = StudentAttendPost.find(params[:id])
    @application.update(status: 'rejected')
    redirect_to post_path(@application.post), notice: 'Application rejected.'
  end

  def close
    @post = Post.find(params[:id])
    @post.update(status: 'close')
    redirect_to post_path(@post), notice: 'Post was successfully closed.'
  end


  private
  
  def post_params
    params.require(:post).permit(:creator_name, :course, :tag, :text, :status, :start_slot, :end_slot)
  end
end
