class PasswordResetsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送信しました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが登録されていないか、間違っています"
      render 'new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
      flash[:warning] = "不正なアクセスです"
    end
  end

  


end
