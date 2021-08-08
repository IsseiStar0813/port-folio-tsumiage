require "test_helper"

class UserLogoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:issei)
  end

  test "logout after login with valid infomation " do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert logged_in?
    delete logout_path
    assert_not logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_not flash.empty?                           
  end

end
