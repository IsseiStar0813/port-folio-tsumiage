require "test_helper"

class CalendersControllerTest < ActionDispatch::IntegrationTest
  test "should get calender" do
    get calender_path
    assert_response :success
  end
end
