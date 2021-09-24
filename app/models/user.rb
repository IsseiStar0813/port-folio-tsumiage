class User < ApplicationRecord

  has_many :posts, dependent: :destroy

    validates :name, presence: :true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, uniqueness: true 
    validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
    has_secure_password
    validates :password, length: { minimum: 6 }, presence: true, allow_nil: true
    
    

    
  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを作成
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 作成したトークンをデータベースに保存
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 全ユーザーのalready_postedをfalse(未投稿の状態)にする
  def self.make_user_unposted
    users = User.all
    users.each do |user|
      user.update_attribute(:already_posted, false)
    end
  end

end
