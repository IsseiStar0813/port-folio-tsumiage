class PasswordResetsController < ApplicationController
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:purple] = "パスワード再設定用のメールを送信しました"
      redirect_to root_url
    else
      flash.now[:red] = "メールアドレスが登録されていないか、間違っています"
      render 'new'
    end
  end

  def edit
  end

  def update
    unless params[:user][:password].empty?
      # パスワードが空じゃない場合
      if @user.update(user_params)
        # 更新が成功した場合
        log_in @user
        flash[:purple] = "パスワードを変更しました"
        redirect_to @user
      else
        # 更新に失敗した場合
        render "edit"
      end
    else
      # パスワードが空の場合
      @user.errors.add(:password, :blank)
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # 期限が切れていないか確認する
  def check_expiration
    if @user.password_reset_expired?
      flash[:red] = "再設定の期限が切れています"
      redirect_to new_password_reset_url
    end
  end

  # 正しいユーザーかどうか確認する
  def valid_user
    @user = User.find_by(email: params[:email])
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  


end
