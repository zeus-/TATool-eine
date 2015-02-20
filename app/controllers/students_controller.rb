class StudentsController < ApplicationController
  def new
    @student = Student.new
    # render nothing: true
  end

  def create
    @student = Student.new student_params
    if @student.save
      session[:student_id] = @student.id
      redirect_to root_path, notice: "Account Created!"
    else
      flash[:alert] = "Account not created"
      render :new
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name,
                                 :email, :password,
                                 :password_confirmation)
  end
end
