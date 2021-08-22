require "test_helper"

class PostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:issei)
    @other = users(:yuuka)
    @post = @user.posts.build(content: "テスト中")
    end

    test "should be valid" do
      assert @post.valid?
    end
  
    test "user id should be present" do
      @post.user_id = nil
      assert_not @post.valid?
    end
  
    test "content should be present" do
      @post.content = ""
      assert_not @post.valid?
    end

    test "recent post should be ordered first" do
      assert_equal posts(:most_recent), Post.first
    end

    

end
