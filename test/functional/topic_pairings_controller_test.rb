require 'test_helper'

class TopicPairingsControllerTest < ActionController::TestCase
  setup do
    @topic_pairing = topic_pairings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topic_pairings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic_pairing" do
    assert_difference('TopicPairing.count') do
      post :create, topic_pairing: { child: @topic_pairing.child, parent: @topic_pairing.parent }
    end

    assert_redirected_to topic_pairing_path(assigns(:topic_pairing))
  end

  test "should show topic_pairing" do
    get :show, id: @topic_pairing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic_pairing
    assert_response :success
  end

  test "should update topic_pairing" do
    put :update, id: @topic_pairing, topic_pairing: { child: @topic_pairing.child, parent: @topic_pairing.parent }
    assert_redirected_to topic_pairing_path(assigns(:topic_pairing))
  end

  test "should destroy topic_pairing" do
    assert_difference('TopicPairing.count', -1) do
      delete :destroy, id: @topic_pairing
    end

    assert_redirected_to topic_pairings_path
  end
end
