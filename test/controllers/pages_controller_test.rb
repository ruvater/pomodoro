require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get start_work" do
    get :start_work
    assert_response :success
  end

  test "should get categories" do
    get :categories
    assert_response :success
  end

  test "should get statistics" do
    get :statistics
    assert_response :success
  end

end
