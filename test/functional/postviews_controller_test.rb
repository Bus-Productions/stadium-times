require 'test_helper'

class PostviewsControllerTest < ActionController::TestCase
  setup do
    @postview = postviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:postviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create postview" do
    assert_difference('Postview.count') do
      post :create, postview: { post_id: @postview.post_id, user_id: @postview.user_id }
    end

    assert_redirected_to postview_path(assigns(:postview))
  end

  test "should show postview" do
    get :show, id: @postview
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @postview
    assert_response :success
  end

  test "should update postview" do
    put :update, id: @postview, postview: { post_id: @postview.post_id, user_id: @postview.user_id }
    assert_redirected_to postview_path(assigns(:postview))
  end

  test "should destroy postview" do
    assert_difference('Postview.count', -1) do
      delete :destroy, id: @postview
    end

    assert_redirected_to postviews_path
  end
end
