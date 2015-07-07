class UsersController < ApplicationController
  def index
    if current_user
      if current_user.role == "admin"
        @users = User.all
      elsif current_user.role == "reader"
        redirect_to user_articles_path(current_user)
      else
        redirect_to articles_publisher_path
      end
    else
      redirect_to login_path
    end
  end

  def new
     @user=User.new
  end
  
  def edit  
    @user = current_user  
  end  

  def create
    @user = User.new(user_params)
      if @user.save!
        flash[:success]= "Registration successfull"
        redirect_to login_path
        else
          render :action => 'new'
        end
      end
  
  def update  
    @user = current_user  
    if @user.update_attributes(params[:user])  
      flash[:success] = "Successfully updated profile."  
      redirect_to @user 
      else  
        render :action => 'edit'
      end  
    end  
  
  
  private
  def user_params
    params.require(:user).permit(:username,:email,:password,:password_confirmation,:role)
  end
end
