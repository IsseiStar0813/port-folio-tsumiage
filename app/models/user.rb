class User < ApplicationRecord
    validates :name, presence: :true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, uniqueness: true 
    validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
    has_secure_password
    validates :password, length: { minimum: 6 }, presence: true
    validates :password_confirmation, presence: true
    

    
    # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
