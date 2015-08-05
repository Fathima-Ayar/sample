class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:destroy]
  def index
    if current_user
      if current_user.role == "admin"
        @users = User.all
      elsif current_user.role == "reader"
        redirect_to user_articles_path(current_user)
      elsif current_user.role == "publisher"
        redirect_to publisher_article_path(current_user)
      else
         redirect_to user_articles_path(current_user)
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
       UserMailer.registration_confirmation(@user).deliver
        flash[:notice] = "Please confirm your email address to continue"
        redirect_to new_user_path
      else
        flash[:error] = "Ooooppss, something went wrong!"
        render :action => 'new'
    end
  end
  
  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      @user.email_activate
      flash[:notice] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_path
    else
      flash[:error] = "Sorry. User does not exist"
      render 'new'
    end
  end

  def update  
    @user = current_user  
      if @user.update_attributes(user_params)
      flash[:success] = "Successfully updated profile."  
      redirect_to root_path
    else  
      render :action => 'edit'
    end  
  end  

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user=User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
 
  def change_password
    @user = current_user
  end

  
private
  def user_params
    params.require(:user).permit(:username,:email,:password,:password_confirmation,:role,:is_female,:date_of_birth,:avatar)
  end
end
