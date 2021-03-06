require "test_helper"

class UsersDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:issei)
  end

  test "user should delete" do
    log_in_for_test(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
    assert_not flash.empty?
    assert_not logged_in?
    assert_redirected_to root_url
  end 
end
