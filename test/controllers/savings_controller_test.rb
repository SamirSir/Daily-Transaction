require 'test_helper'

class SavingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get savings_index_url
    assert_response :success
  end

end
