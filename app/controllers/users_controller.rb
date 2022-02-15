class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
 
  def new
    @user = User.new
  end

  def show 
    @user = User.find(current_user.id)
    @posts = @user.posts
    @today =  Date.current
    @schedules = current_user.schedules.where(start_time: @today.in_time_zone.all_day)
    @schedule = current_user.schedules.build
    @total = 0
    @schedules.each do |schedule|
      @total += (schedule.total_hours * 60) + schedule.total_minutes
    end
    @total_hours = @total / 60
    @total_minutes = @total % 60
    @achieved_schedules = current_user.schedules.where(start_time: @today.in_time_zone.all_day, achieved: true)
    @actual_total = 0
    @achieved_schedules.each do |schedule|
      @actual_total += (schedule.total_hours * 60) + schedule.total_minutes
    end
    @actual_total_hours = @actual_total /60
    @actual_total_minutes = @actual_total % 60
    @whole_schedules = current_user.schedules.where(achieved: true)
    @whole_total = 0
    @whole_schedules.each do |schedule|
      if schedule.total_hours || schedule.total_minutes
        @whole_total += (schedule.total_hours * 60) + schedule.total_minutes
      end
    end
    @whole_total_hours = @whole_total /60
    @whole_total_minutes = @whole_total % 60
   

  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 登録成功
      UserMailer.account_activation(@user).deliver_now
      flash[:green] = "アカウント有効化用のメールを送信しました"
      redirect_to root_url
    else
      # 登録失敗
      render "new"
    end
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新成功
      flash[:green] = "情報を更新しました"
      redirect_to @user
    else
      # 更新失敗
      render 'edit'
    end
  end

  def destroy 
    @user = User.find(params[:id])
    log_out
    @user.destroy
    flash[:red] = "ユーザーを削除しました"
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
