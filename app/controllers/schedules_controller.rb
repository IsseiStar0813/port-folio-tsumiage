class SchedulesController < ApplicationController
  before_action :logged_in_user
  before_action :require_created_params, only: :index


  def show 
    @tasks = current_user.schedules.all
  end

  def new
    @schedule = current_user.schedules.build
  end

  def create 
    @schedule = current_user.schedules.build(schedule_params)
    if @schedule.save
      # 投稿成功
      redirect_to schedule_path(current_user)
      flash[:green] = "予定を追加しました"
    else
      # 投稿失敗
      render "new"
    end
  end

  def index
    @posted_day = params[:created]
    @schedules = current_user.schedules.where(created_at: @posted_day.in_time_zone.all_day)
  end

  private
    def schedule_params
      params.require(:schedule).permit(:task, :start_time, :hours)
    end

end
