class HomeController < ApplicationController
  before_action :authenticate_ta!, only: :index
  def new

  end
  def index
   @hrs = current_user.help_requests.all if current_user.help_requests
   @pending_hrs = @hrs.where("is_complete = false")
   @ta = current_user
  end
end
