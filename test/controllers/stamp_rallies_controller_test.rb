require "test_helper"

class StampRalliesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stamp_rallies_index_url
    assert_response :success
  end

  test "should get new" do
    get stamp_rallies_new_url
    assert_response :success
  end

  test "should get show" do
    get stamp_rallies_show_url
    assert_response :success
  end
end
