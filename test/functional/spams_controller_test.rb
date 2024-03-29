require 'test_helper'

class SpamsControllerTest < ActionController::TestCase
  setup do
    @spam = spams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spam" do
    assert_difference('Spam.count') do
      post :create, spam: { comment_id: @spam.comment_id, post_id: @spam.post_id, user_id: @spam.user_id }
    end

    assert_redirected_to spam_path(assigns(:spam))
  end

  test "should show spam" do
    get :show, id: @spam
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spam
    assert_response :success
  end

  test "should update spam" do
    put :update, id: @spam, spam: { comment_id: @spam.comment_id, post_id: @spam.post_id, user_id: @spam.user_id }
    assert_redirected_to spam_path(assigns(:spam))
  end

  test "should destroy spam" do
    assert_difference('Spam.count', -1) do
      delete :destroy, id: @spam
    end

    assert_redirected_to spams_path
  end
end
