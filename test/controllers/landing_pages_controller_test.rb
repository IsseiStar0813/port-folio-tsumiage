require "test_helper"

class LandingPagesControllerTest < ActionDispatch::IntegrationTest
  
  test "root header should be displayed when visit the landing page" do
    get root_path
    assert_template "landing_pages/home"
    assert_template "layouts/_root_header"
  end

end
