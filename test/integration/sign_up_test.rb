require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "Invalid signup information name" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post users_path, params: {user:{name: "", email: "example@example.com",
      password: "password", password_confirmation: "password"}}
    end
    assert_template "users/new"
  end

  test "Invalid signup information email" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post users_path, params: {user:{name: "name", email: "",
      password: "password", password_confirmation: "password"}}
    end
    assert_template "users/new"
  end

  test "Invalid signup information password" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post users_path, params: {user:{name: "name", email: "example@example.com",
      password: "passworddd", password_confirmation: "password"}}
    end
    assert_template "users/new"
  end

  test "Invalid signup information password blank" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post users_path, params: {user:{name: "name", email: "example@example.com",
      password: "passworddd", password_confirmation: ""}}
    end
    assert_template "users/new"
  end



  test "valid signup information" do
    assert_difference "User.count", +1 do
      post users_path, params: {user:{name:"name", email: "example@example.com",
      password: "password", password_confirmation: "password"}}
    end
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # 有効化していない状態でログインしてみる
    log_in_for_test(user)
    assert_not logged_in?
    # 有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not logged_in?
    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not logged_in?
    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
  end

  

end
