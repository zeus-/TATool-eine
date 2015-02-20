class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    unless user_signed_in?
      redirect_to new_session_path, alert: "Please sign in"
    end
  end

  def user_signed_in?
    session[:student_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= Student.find session[:student_id] if user_signed_in?
  end
  helper_method :current_user

end
