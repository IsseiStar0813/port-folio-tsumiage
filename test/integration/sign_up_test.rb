require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  
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


  test "valid signup information" do
    assert_difference "User.count", +1 do
      post users_path, params: {user:{name:"name", email: "example@example.com",
      password: "password", password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template "users/show"
    assert logged_in?
    assert_not flash.empty?
  end

end
