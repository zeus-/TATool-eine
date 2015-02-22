class HelpRequestsController < ApplicationController
  
  before_action :authenticate_student!
  before_action :find_hr, only: [:edit, :update, :destroy]
  def index    
    @available_tas = TaUser.where("is_available = true")
  end
  
  def new  
    @hr = HelpRequest.new
  end

  def create    
    @hr = HelpRequest.new(help_request_params)
    @hr.student = current_user
    if @hr.save
      redirect_to request.referer, notice: "Your HR was created successfully"
    else
      flash.now[:alert] = "Please correct the form"
      render :new
    end
  end
 
  def destroy
    if @help_request.destroy 
      redirect_to student_help_requests_path, notice: "Deleted HR"
    else
      flash.now[:alert] = "Cant delete this HR"
      render :index
    end
  end

   
  private
    def help_request_params
      help_request_params = params.require(:help_request).permit(:description, :ta_user_id, :is_completed)
    end
    def find_hr
    @help_request = current_user.help_requests.find_by_id(params[:id])
    redirect_to root_path, alert: "Access denied, foo" unless @help_request
    end
end
