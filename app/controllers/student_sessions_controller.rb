class StudentSessionsController < ApplicationController

  def new
    @student = Student.new
  end

  def create
    @student = Student.find_by_email params[:student][:email]
    if @student && @student.authenticate(params[:student][:password])
      session[:student_id] = @student.id
      redirect_to root_path
    else
      flash[:alert] = "Wrong email or password"
      render :new
    end
  end

  def destroy
    session[:student_id] = nil
    redirect_to root_path
  end

end
