require 'test_helper'

class IncomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get incomes_index_url
    assert_response :success
  end

end
