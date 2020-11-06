require 'test_helper'

class LoansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get loans_index_url
    assert_response :success
  end

end
