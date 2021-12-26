class ApplicationController < ActionController::Base
  include SessionsHelper

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:red] = " ログインしてください"
      redirect_to login_url
    end
  end

  # 正しいユーザーか確認
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:red] = "自分以外の情報は確認できません"
      redirect_to root_url
    end
  end

  # params [:created]を要求
  def require_created_params
    unless params[:created]
      redirect_to current_user
    end
  end
end
