class QuestionsController < ApplicationController
    
  def index
  end

  def show
    @user = User.find_by_id(params[:id])
     @total_questions = Question.count
    render :action => "index"
  end

  def survey
    @user = User.find_by_id(params[:userid])
    @step = params[:step]
    @total_questions = Question.count

    if @step.to_i <= @total_questions

      #    get new question
      already_taken = @user.answers.size == 0 ? 0 : @user.answers.collect {|x| x.question_id}.join(",")
      @question = Question.find(:first, :conditions => "id NOT IN (#{already_taken})")

      @answer = Answer.new({:question => @question, :user => @user})

      render :action => "show"
    else
      render :partial => "thoughts", :layout => "application", :locals => {:user => @user}
    end
    
  end

  def admin_view
    @questions = Question.find(:all)
    @question = Question.new
    render :admin_view
  end

  def create
    if Question.create(params[:question])
      flash.notice = "Question Added"
      admin_view
    end
  end


  def destroy
    begin
      question = Question.find(params[:id])
      if question.delete
        flash.notice = "Question Deleted"
      end
    rescue

    end
    admin_view
  end

 

end
