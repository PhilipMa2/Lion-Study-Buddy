class PostsController < ApplicationController
  before_action :require_student, only: [:new, :create]

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

  private
  
  def post_params
    params.require(:post).permit(:course, :schedule, :tag, :text)
  end
end
