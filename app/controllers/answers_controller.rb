class AnswersController < ApplicationController
  before_action :logged_in_user
  before_action :require_question_params, only: :new

  def new
    @question = Question.find(params[:question])
    @answer = @question.answers.build
  end

  def create 
    @question = Question.find_by(id: params[:question])
    @answer = @question.answers.build(answer_params)
    if @answer.save
      flash[:green] = "質問に回答しました"
      redirect_to questions_path
    else
      render "new"
    end
  end

  # params[:question]を要求
  def require_question_params
    unless params[:question]
      redirect_to current_user
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:content)
    end
end
