class HomeController < ApplicationController
  before_action :authenticate_ta!, only: :index
  before_action :authenticate_student!, only: :student_index
  
  def new

  end

  def index
   @hrs = current_user.help_requests.all if current_user.help_requests
   @pending_hrs = @hrs.where("is_complete = false")
   @ta = current_user
  end
  
  def student_index   
    #@ta = TaUser.find(params[:ta_user_id])
    #@hrs = @ta.help_requests.all
    #@pending_hrs = @hrs.where("is_complete = false")
  end

end
