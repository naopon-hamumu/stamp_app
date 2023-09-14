require "test_helper"

class StampsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stamps_index_url
    assert_response :success
  end
end
