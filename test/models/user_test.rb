require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:issei)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be presence" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email should not be too long" do 
    @user.email = "a" * 256
    assert_not @user.valid?
  end


  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated posts should be destroyed" do
    assert_difference 'Post.count', -3 do
      @user.destroy
    end
  end

  test "user should be unposted" do
    make_user_unposted_for_test
    @other = users(:yuuka)
    assert_equal @other.already_posted, false
  end

  test "authenticated? should return false with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end


end
