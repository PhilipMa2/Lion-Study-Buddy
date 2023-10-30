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
    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def attend
    @student = current_student
    @post = Post.find(params[:id])
    already_attended = StudentAttendPost.exists?(student: @student, post: @post)

    unless already_attended
        StudentAttendPost.create(student: @student, post: @post)
        flash[:notice] = 'You are now attending this post!'
    else
        flash[:alert] = 'You are already attending this post!'
    end

    redirect_to post_path(@post)
  end

  def confirm
    @post = Post.find(params[:id])
    @post.update(status: 'confirmed')
    redirect_to post_path(@post), notice: 'Post was successfully confirmed.'
  end

  def cancel
    @post = Post.find(params[:id])
    @post.update(status: 'cancelled')
    redirect_to post_path(@post), alert: 'Post was successfully cancelled.'
  end






  private
  
  def post_params
    params.require(:post).permit(:course, :schedule, :tag, :text)
  end
end
