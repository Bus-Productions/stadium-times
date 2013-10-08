require 'test_helper'

class TopicFollowsControllerTest < ActionController::TestCase
  setup do
    @topic_follow = topic_follows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_follows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_follow" do
    assert_difference('TopicFollow.count') do
      post :create, topic_follow: { manual_follow: @topic_follow.manual_follow, topic_id: @topic_follow.topic_id, user_id: @topic_follow.user_id }
    end

    assert_redirected_to topic_follow_path(assigns(:topic_follow))
  end

  test "should show topic_follow" do
    get :show, id: @topic_follow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_follow
    assert_response :success
  end

  test "should update topic_follow" do
    put :update, id: @topic_follow, topic_follow: { manual_follow: @topic_follow.manual_follow, topic_id: @topic_follow.topic_id, user_id: @topic_follow.user_id }
    assert_redirected_to topic_follow_path(assigns(:topic_follow))
  end

  test "should destroy topic_follow" do
    assert_difference('TopicFollow.count', -1) do
      delete :destroy, id: @topic_follow
    end

    assert_redirected_to topic_follows_path
  end
end
