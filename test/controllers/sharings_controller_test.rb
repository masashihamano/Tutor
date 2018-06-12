require 'test_helper'

class SharingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sharings_index_url
    assert_response :success
  end

  test "should get show" do
    get sharings_show_url
    assert_response :success
  end

  test "should get new" do
    get sharings_new_url
    assert_response :success
  end

  test "should get create" do
    get sharings_create_url
    assert_response :success
  end

  test "should get edit" do
    get sharings_edit_url
    assert_response :success
  end

  test "should get update" do
    get sharings_update_url
    assert_response :success
  end

end
