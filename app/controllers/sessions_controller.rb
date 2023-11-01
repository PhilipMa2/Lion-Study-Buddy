class SessionsController < ApplicationController
  def new
  end

  def create
    student = Student.authenticate(params[:email], params[:passcode])
    if !student.nil?
      session[:student_id] = student.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or passcode'
      puts "Flash Message: #{flash.now[:alert]}"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'Logged out successfully'
  end
end
