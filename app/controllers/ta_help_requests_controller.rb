class TaHelpRequestsController < ApplicationController
  
  before_action :authenticate_ta!
  before_action :find_hr, only: [:edit, :update, :destroy]
  
  def index    
    @hrs = current_user.help_requests.all if current_user.help_requests
    @ta = current_user
  end

  def destroy
    if @help_request.destroy 
      redirect_to ta_help_requests_path, notice: "Deleted HR"
    else
      flash.now[:alert] = "Cant delete this HR"
      render :index
    end
  end
 
  private
    def help_request_params
      help_request_params = params.require(:help_request).permit(:description, :is_completed)
    end
    def find_hr
    @help_request = current_user.help_requests.find_by_id(params[:id])
    redirect_to root_path, alert: "Access denied, foo" unless @help_request
    end
end
