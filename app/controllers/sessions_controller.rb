class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン成功
      log_in(user)
      flash[:success] = "ログインしました"
      redirect_to user
    else
      # ログイン失敗
      flash.now[:danger] = "メールアドレスかパスワードが間違っています"
      render "sessions/new"
    end
  end

  def destroy
  end
end
