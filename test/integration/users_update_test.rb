require "test_helper"

class UsersUpdateTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:issei)
  end

  test "update with valid information" do
    get edit_user_path(@user)
    assert_template "users/edit"
    name = "issei"
    email = "issei@example.com"
    patch user_path(@user), params: { user: { name:  name,
      email: email,
      password:              "",
      password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    follow_redirect!
    assert_template "users/show"
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  test "update with invalid information" do
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name: "issei",
      email: "issei@example.com",
      password:              "pass",
      password_confirmation: "word" } }
    assert_template "users/edit"
  end

end
