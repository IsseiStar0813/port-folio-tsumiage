class SchedulesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :show

  def show 
    @tasks = current_user.schedules.all
  end

  def new
    @schedule = current_user.schedules.build
  end

  def create 
    @schedule = current_user.schedules.build(schedule_params)
    if @schedule.save
      redirect_to current_user
      flash[:green] = "予定を追加しました"
    end
  end

  private
    def schedule_params
      params.require(:schedule).permit(:task, :start_time, :hours)
    end

end
