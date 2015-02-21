class SessionsController < ApplicationController

  def new_student
    @user = Student.new
  end

  def new_ta_user
    TaUser.new  
  end

  def create
    @student = Student.find_by_email params[:student][:email] if params[:student]
    @ta_user = TaUser.find_by_email params[:ta_user][:email] if params[:ta_user]
    
    if @student && @student.authenticate(params[:student][:password])
      session[:student_id] = @student.id
      redirect_to root_path, notice: "Logged in!"
    elsif @ta_user && @ta_user.authenticate(params[:ta_user][:password])
      session[:ta_user_id] = @ta_user.id
      redirect_to root_path, notice: "Logged in!"
    elsif params[:student] 
      flash[:alert] = "Wrong email or password"
      render :new_student
    elsif params[:ta_user] 
      flash[:alert] = "Wrong email or password"
      render :new_ta_user
    end
  end

  def destroy
    session[:ta_user_id] = nil
    session[:student_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end


end
