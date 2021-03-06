class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  has_many :posts, dependent: :destroy 
  has_many :schedules, dependent: :destroy
  has_many :questions, dependent: :destroy

    validates :name, presence: :true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, uniqueness: true 
    validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
    has_secure_password
    validates :password, length: { minimum: 6 }, presence: true, allow_nil: true
    
    

  # メールアドレスをすべて小文字にする
  def downcase_email
    self.email = email.downcase
  end

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
    
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
  def remember_db
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーの記憶ダイジェストをデータベースから削除
  def forget_db
    update_attribute(:remember_digest, nil)
  end

   # パスワード再設定の属性を設定
   def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合(30分以上経過している場合)はtrueを返す
  def password_reset_expired?
    reset_sent_at < 30.minutes.ago
  end

  
  # 全ユーザー未投稿状態にする
  def self.make_user_unposted
    users = User.all
    users.each do |user|
      user.update_attribute(:already_posted, false)
    end
  end

end
