class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
 
  def new
    @user = User.new
  end

  def show 
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 登録成功
      UserMailer.account_activation(@user).deliver_now
      flash[:purple] = "アカウント有効化用のメールを送信しました"
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
      flash[:purple] = "情報を更新しました"
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

  

  # beforeアクション

    # 正しいユーザーか確認
    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:red] = "自分以外の情報は確認できません"
        redirect_to root_url
      end
    end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
