require "test_helper"

class CalenderControllerTest < ActionDispatch::IntegrationTest
  test "should get calender" do
    get calender_calender_url
    assert_response :success
  end
end
