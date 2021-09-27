require "test_helper"

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:issei)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "メールアドレスの確認", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
  end

end
