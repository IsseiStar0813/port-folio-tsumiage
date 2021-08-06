class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 登録成功
      flash[:success] = "ユーザー登録完了"
      redirect_to @user
    else
      # 登録失敗
      render "new"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end
