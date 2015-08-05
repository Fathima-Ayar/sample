class UserSessionsController < ApplicationController
  
  def new
    @user_session=UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])  
    if @user_session.save
      if current_user.role=='admin'
        redirect_to root_path  
        else @user && @user.email_confirmed
          flash[:success] = "Login successful."
          redirect_to root_path 
        end
    else
     
      redirect_to new_user_session_path, notice: "Invalid user/password combination"
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_path
  end
end
