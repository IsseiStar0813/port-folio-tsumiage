require "test_helper"

class PostingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:issei)
  end
  
  test "should be posted correctly" do
    log_in_for_test(@user)
    get new_post_path
    assert_template "posts/new"
    assert_difference "Post.count", + 1 do
      post posts_path, params: {post:{title: "テスト", 
                                content: "テスト中"}}
    end
    assert_not flash.empty?
    follow_redirect!
    assert_template "users/show"
  end

  test "should not be posted" do
    log_in_for_test(@user)
    get new_post_path
    assert_template "posts/new"
    assert_no_difference "Post.count" do
      post posts_path, params: {post:{content: ""}}
    end
    assert_template "posts/new"
  end
  
end
