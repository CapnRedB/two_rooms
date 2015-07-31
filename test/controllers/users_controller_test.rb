require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @swap = swaps(:one)
  end

  test "should require authentication" do
    users(:joe).save
    for_users

    before = users(:joe).name

    put :update, foramt: :json, user: {name: "Jose"}
    #p @response.body
    assert_response :redirect, "Should require logged in"
    assert_equal before, users(:joe).name, "Name should not have changed"
  end

  test "should allow you to update your name" do
  end

  test "should reject duplicate names" do
  end

  test "should reject blank name" do
  end


#   test "should get index" do
#     get :index
#     assert_response :success
#     assert_not_nil assigns(:swaps)
#   end

#   test "should get new" do
#     get :new
#     assert_response :success
#   end

#   test "should create swap" do
#     assert_difference('Swap.count') do
#       post :create, swap: { count: @swap.count, player_max: @swap.player_max, player_min: @swap.player_min, round_id: @swap.round_id }
#     end

#     assert_redirected_to swap_path(assigns(:swap))
#   end

#   test "should show swap" do
#     get :show, id: @swap
#     assert_response :success
#   end

#   test "should get edit" do
#     get :edit, id: @swap
#     assert_response :success
#   end

#   test "should update swap" do
#     patch :update, id: @swap, swap: { count: @swap.count, player_max: @swap.player_max, player_min: @swap.player_min, round_id: @swap.round_id }
#     assert_redirected_to swap_path(assigns(:swap))
#   end

#   test "should destroy swap" do
#     assert_difference('Swap.count', -1) do
#       delete :destroy, id: @swap
#     end

#     assert_redirected_to swaps_path
#   end
end
