require 'test_helper'

class GameLogsControllerTest < ActionController::TestCase
  setup do
    logged_in
    @game_log = game_logs(:one)
  end

  test "should get index" do
    get :index, format: :json, game_id: games(:one).id
    assert_response :success
    assert_not_nil assigns(:game_logs)
  end

end
