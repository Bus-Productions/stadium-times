require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get settings" do
    get :settings
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get legal" do
    get :legal
    assert_response :success
  end

  test "should get stadium" do
    get :stadium
    assert_response :success
  end

end
