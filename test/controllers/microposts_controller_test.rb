require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:issei)
    @micropost = microposts(:apple)
  end

  test "should redirect new when not logged in" do
    get new_micropost_path
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "テスト" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should be deleted" do
    log_in_for_test(users(:issei))
    assert_difference "Micropost.count", - 1 do
      delete micropost_path(@micropost)
    end
    assert_not flash.empty?
    follow_redirect!
    assert_template "users/show"
  end

  test "should not be deleted" do
    log_in_for_test(users(:yuuka))
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "correct posting" do
    log_in_for_test(@user)
    assert_difference "Micropost.count", + 1 do
      post microposts_path, params: { micropost: { content: "テスト" } }
    end  
    assert_not flash.empty?
    follow_redirect!
    assert_template "users/show"
  end

end
