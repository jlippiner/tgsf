class UsersController < ApplicationController
  def index
    redirect_to new_user_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])

    if @user
      #      flash.notice = "Sorry but you can only take the survey once."
      @user.update_attributes(params[:user])
      @user.answers.delete_all
      redirect_to question_path(@user)  if @user.update_attributes(params[:user])
    else
      @user = User.new(params[:user])

      if @user.save
        flash.notice = "User account created!"
         redirect_to question_path(@user)
      else
        render :action => "new"
      end
    end    
  end

  def update
    user = User.find(params[:id])

    unless (params[:user][:thoughts].blank?)
      if user.update_attributes(params[:user])
        render :text => "Thank you!", :layout => "application"
      end
    else
      flash.warning = "Please enter your thoughts below..."
      redirect_to question_survey_path(user.id, "6")
    end
  end

  def admin_view
    @users = User.find(:all)
  end

end
