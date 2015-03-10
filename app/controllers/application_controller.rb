class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_student!
    unless student_signed_in?
      redirect_to login_as_student_path
    end
  end

  def student_signed_in?
    session[:student_id].present?
  end
  helper_method :student_signed_in?

  def current_user
    (@current_student ||= Student.find session[:student_id] if student_signed_in?) || (@current_ta ||= TaUser.find session[:ta_user_id] if ta_signed_in?)
  end
  helper_method :current_user


# authentication helpers for TA Users
  
  def authenticate_ta!
    unless ta_signed_in?
      redirect_to login_as_ta_path, alert: "Please sign in as a TA"
    end
  end

 def ta_signed_in?
   session[:ta_user_id].present?
 end
 helper_method :ta_signed_in?

end
