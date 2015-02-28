class TaHelpRequestsController < ApplicationController
  
  before_action :authenticate_ta!
  before_action :find_hr, only: [:edit, :update, :destroy]
  
  def index    
    @hrs = current_user.help_requests.all if current_user.help_requests
    @pending_hrs = @hrs.where("is_complete = false")
    #@ta = current_user
    render json: @pending_hrs
  end
  def complete_requests
    @hrs = current_user.help_requests.all if current_user.help_requests
    @incomplete_hrs = @hrs.where("is_complete = true").order("created_at DESC").limit(5)
    #@ta = current_user
    render json: @incomplete_hrs
  end
  def update 
    if @help_request.update(help_request_params)
      render nothing: true 
      #redirect_to ta_help_requests_path, notice: " Done!"
    else
      flash.now[:alert] = "Cant update this HR"
      render :index
    end
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
      help_request_params = params.require(:help_request).permit(:description, :student_id, :is_complete)
    end
    def find_hr
    @help_request = current_user.help_requests.find_by_id(params[:id])
    redirect_to root_path, alert: "Access denied, foo" unless @help_request
    end
end
