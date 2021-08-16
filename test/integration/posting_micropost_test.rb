require "test_helper"

class PostingMicropostTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:issei)
  end
  
  test "should be posted correctly" do
    log_in_for_test(@user)
    get new_micropost_path
    assert_template "microposts/new"
    assert_difference "Micropost.count", + 1 do
      post microposts_path, params: {micropost:{content: "テスト中"}}
    end
    assert_not flash.empty?
    follow_redirect!
    assert_template "users/show"
  end

  test "should not be posted" do
    log_in_for_test(@user)
    get new_micropost_path
    assert_template "microposts/new"
    assert_no_difference "Micropost.count" do
      post microposts_path, params: {micropost:{content: ""}}
    end
    assert_template "microposts/new"
  end
  
end
