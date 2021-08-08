class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def show 
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 登録成功
      log_in(@user)
      flash[:success] = "ユーザー登録完了"
      redirect_to @user
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
      flash[:success] = "情報を更新しました"
      redirect_to @user
    else
      # 更新失敗
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
