class ApplicationController < ActionController::Base
  include SessionsHelper

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:red] = " ログインしてください"
      redirect_to login_url
    end
  end
end
