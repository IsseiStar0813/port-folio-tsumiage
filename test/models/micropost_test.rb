require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:issei)
    @micropost = @user.microposts.build(content: "テスト中")
    end

    test "should be valid" do
      assert @micropost.valid?
    end
  
    test "user id should be present" do
      @micropost.user_id = nil
      assert_not @micropost.valid?
    end
  
    test "content should be present" do
      @micropost.content = ""
      assert_not @micropost.valid?
    end
  
    test "content's maximum number of characters are 140" do
      @micropost.content = "a" * 141
      assert_not @micropost.valid?
    end

    test "recent micropost should be ordered first" do
      assert_equal microposts(:most_recent), Micropost.first
    end


end
