ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # ログイン中か確認
  def logged_in?
    !session[:user_id].nil?
  end

  # テストユーザーでログイン
  def log_in_for_test(user)
    session[:user_id] = user.id
  end
end

# 全ユーザーのalready_postedをfalse(未投稿の状態)にする
def make_user_unposted_for_test
  users = User.all
  users.each do |user|
    user.update_attribute(:already_posted, false)
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_for_test(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: password } }
  end



end
