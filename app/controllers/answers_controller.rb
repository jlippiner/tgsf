class AnswersController < ApplicationController
  def new
  end

  def create
    form = params[:answer]
    user = User.find(form[:user_id])

    answer = Answer.new(form)
    if answer.save
      step = params[:step].succ
      redirect_to question_survey_path(user.id, step.to_s)
    else
      redirect_to question_survey_path(user.id, params[:step])
    end
  end
end
