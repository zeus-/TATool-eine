class HomeController < ApplicationController
  before_action :authenticate_ta!, only: :index
  before_action :authenticate_student!, only: :student_index
  
  def new
    render :layout => 'external'
  end

  def index
   @pending_hrs = current_user.help_requests.where("is_complete = false")
   @ta = current_user
  end
  
  def student_index   
    @available = TaUser.available
    #@available_tas = render json: @available, each_serializer: TaSerializer, root: false
  end
    #@ta = TaUser.find(params[:ta_user_id])
    #@hrs = @ta.help_requests.all
    #@pending_hrs = @hrs.where("is_complete = false")

end
