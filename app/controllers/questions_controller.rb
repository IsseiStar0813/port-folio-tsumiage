class QuestionsController < ApplicationController
  before_action :logged_in_user

  def new
    @question = current_user.questions.build 
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      # 質問投稿成功
      flash[:green] = "投稿しました"
      redirect_to questions_path
    else
      # 質問投稿失敗
      render "new"
    end
  end

  def index
    @questions = Question.all
  end

  def my_questions
    @my_questions = current_user.questions.all
  end

  def question_solved 
    @question = current_user.questions.find(params[:question])
    unless @question.solved
      @question.update(solved: true)
      redirect_to request.referrer
    end

  end

  private
    def question_params
      params.require(:question).permit(:content, :title)
    end
end
