require 'test_helper'

class RoundsControllerTest < ActionController::TestCase
  setup do
    @round = rounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rounds)
  end

  test "index should respond with json" do
    get :index, format: :json
    assert_response :success
    assert JSON.parse(@response.body)
  end

  test "index.json should include rounds and swaps" do
    get :index, format: :json
    assert_response :success
    assert JSON.parse(@response.body)
    body = JSON.parse(@response.body)
    assert body["rounds"], "Response should contain root node of rounds"
    assert body["swaps"], "Response should contain root node of swaps"
    assert_not body["cards"], "Response should not contain cards"
  end

end
