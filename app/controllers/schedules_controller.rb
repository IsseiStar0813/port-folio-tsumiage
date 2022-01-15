class SchedulesController < ApplicationController
  before_action :logged_in_user
  before_action :require_created_params, only: :index


  def show 
    @tasks = current_user.schedules.all
  end

  def create 
    @schedule = current_user.schedules.build(schedule_params)
    if @schedule.save
      # 投稿成功
      redirect_to request.referrer 
      flash[:green] = "予定を追加しました"
    else
      # 投稿失敗
      render "index"
    end
  end

  def index
    @posted_day = params[:created]
    @schedules = current_user.schedules.where(start_time: @posted_day.in_time_zone.all_day)
    @schedule = current_user.schedules.build
  end

  private
    def schedule_params
      params.require(:schedule).permit(:task, :start_time, :hours, :start, :finish, :work_at)
    end

end
