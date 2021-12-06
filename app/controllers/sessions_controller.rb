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
      flash[:purple] = "ログインしました"
      redirect_to user
      else
        # アカウントが有効化されていない場合
        flash[:red] = "メールを確認し、アカウントを有効化してください"
        redirect_to root_url
      end
    else
      # ログイン失敗
      flash.now[:red] = "メールアドレスかパスワードが間違っています"
      render "sessions/new"
    end
  end

  def destroy
    log_out if logged_in?
    flash[:red] = "ログアウトしました"
    redirect_to root_url
  end
end
