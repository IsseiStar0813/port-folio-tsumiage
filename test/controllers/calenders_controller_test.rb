require "test_helper"

class CalendersControllerTest < ActionDispatch::IntegrationTest
  test "should get calender" do
    get calender_calender_url
    assert_response :success
  end
end
