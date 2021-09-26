class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
      # ログイン成功
      log_in(user)
      remember user
      flash[:success] = "ログインしました"
      redirect_to user
      else
        # アカウントが有効化されていない場合
        flash[:warning] = "メールを確認し、アカウントを有効化してください"
        redirect_to root_url
      end
    else
      # ログイン失敗
      flash.now[:danger] = "メールアドレスかパスワードが間違っています"
      render "sessions/new"
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
end
