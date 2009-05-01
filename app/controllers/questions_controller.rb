class QuestionsController < ApplicationController
  def index
  end

  def show
    @user = User.find_by_id(params[:id])
    render :action => "index"
  end

  def survey
    user = User.find_by_id(params[:userid])
    @step = params[:step]

    if @step.to_i <= 5

      #    get new question
      already_taken = user.answers.size == 0 ? 0 : user.answers.collect {|x| x.question_id}.join(",")
      @question = Question.find(:first, :conditions => "id NOT IN (#{already_taken})")

      @answer = Answer.new({:question => @question, :user => user})

      render :action => "show"
    else
      render :partial => "thoughts", :layout => "application", :locals => {:user => user}
    end
    
  end

end
