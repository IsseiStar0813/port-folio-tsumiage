require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:issei)
    @post = posts(:apple)
  end

  test "should redirect new when not logged in" do
    get new_post_path
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Post.count" do
      post posts_path, params: { post: { content: "テスト" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_post_path(@post)
    assert_redirected_to login_url
  end

  test "should redirect update when not loggen_in" do
    patch post_path(@post), params: {content: "りんご" }
    assert_redirected_to login_url
  end

  test "should be deleted" do
    log_in_for_test(users(:issei))
    assert_difference "Post.count", - 1 do
      delete post_path(@post)
    end
    assert_not flash.empty?
    follow_redirect!
    assert_template "users/show"
  end

  test "should not be deleted" do
    log_in_for_test(users(:yuuka))
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "correct posting" do
    log_in_for_test(@user)
    assert_difference "Post.count", + 1 do
      post posts_path, params: { post: { content: "テスト" } }
    end 
    assert_not flash.empty?
    follow_redirect!
    assert_template "users/show"
  end

end
