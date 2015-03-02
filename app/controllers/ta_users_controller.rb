class TaUsersController < ApplicationController
  def new
    @ta_user = TaUser.new
    # render nothing: true
  end

  def create
    @ta_user = TaUser.new ta_user_params
    if @ta_user.save
      session[:ta_user_id] = @ta_user.id
      redirect_to home_index_path, notice: "Account Created!"
    else
      flash[:alert] = "Account not created"
      render :new
    end
  end
 
   def update
    @ta = TaUser.find_by_id(params[:id])
    if @ta.update( ta_user_params )
       render nothing: true 
    else
      flash[:alert] = "Sorry something went wrong!"
      redirect_to home_index_path
    end
   end

  private

  def ta_user_params
    params.require(:ta_user).permit(:first_name, :last_name,
                                 :email, :password,
                                 :password_confirmation, 
                                 :is_available)
  end
end
