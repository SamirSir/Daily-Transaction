require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get reports_home_url
    assert_response :success
  end

end
