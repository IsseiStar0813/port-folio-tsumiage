class User < ApplicationRecord

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
    validates :name, presence: :true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, uniqueness: true 
    validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
    has_secure_password
    validates :password, length: { minimum: 6 }, presence: true, allow_nil: true
    
    

    
    # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = " ログインしてください"
        redirect_to login_url
      end
    end

    # 正しいユーザーか確認
    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:danger] = "自分以外の情報は確認できません"
        redirect_to root_url
      end
    end


end
