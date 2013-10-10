require 'test_helper'

class PostAndTopicPairingsControllerTest < ActionController::TestCase
  setup do
    @post_and_topic_pairing = post_and_topic_pairings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_and_topic_pairings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_and_topic_pairing" do
    assert_difference('PostAndTopicPairing.count') do
      post :create, post_and_topic_pairing: { post_id: @post_and_topic_pairing.post_id, topic_id: @post_and_topic_pairing.topic_id }
    end

    assert_redirected_to post_and_topic_pairing_path(assigns(:post_and_topic_pairing))
  end

  test "should show post_and_topic_pairing" do
    get :show, id: @post_and_topic_pairing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_and_topic_pairing
    assert_response :success
  end

  test "should update post_and_topic_pairing" do
    put :update, id: @post_and_topic_pairing, post_and_topic_pairing: { post_id: @post_and_topic_pairing.post_id, topic_id: @post_and_topic_pairing.topic_id }
    assert_redirected_to post_and_topic_pairing_path(assigns(:post_and_topic_pairing))
  end

  test "should destroy post_and_topic_pairing" do
    assert_difference('PostAndTopicPairing.count', -1) do
      delete :destroy, id: @post_and_topic_pairing
    end

    assert_redirected_to post_and_topic_pairings_path
  end
end
