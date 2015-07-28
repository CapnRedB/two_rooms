require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  setup do
    @card = cards(:president)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cards)
  end

  test "index should respond with json" do
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:cards)
    assert JSON.parse(@response.body)
  end

  test "index.json should contain cards" do
    get :index, format: :json
    
    body = JSON.parse(@response.body)
    assert body["cards"], "Root of json response shoud contain cards"
  end


end
