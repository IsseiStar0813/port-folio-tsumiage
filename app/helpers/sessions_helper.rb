module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # ログイン中のユーザーがいれば、そのユーザーを返す
  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    end
  end

  # ユーザーがログイン中かどうか判断する
  def logged_in?
    !current_user.nil?
  end

end
