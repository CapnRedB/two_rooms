# require 'test_helper'

# class GameSwapsControllerTest < ActionController::TestCase
#   setup do
#     @game_swap = game_swaps(:one)
#   end

#   test "should get index" do
#     get :index
#     assert_response :success
#     assert_not_nil assigns(:game_swaps)
#   end

#   test "should get new" do
#     get :new
#     assert_response :success
#   end

#   test "should create game_swap" do
#     assert_difference('GameSwap.count') do
#       post :create, game_swap: { a_to_b_id: @game_swap.a_to_b_id, b_to_a_id: @game_swap.b_to_a_id, game_id: @game_swap.game_id, round_id: @game_swap.round_id, sequence: @game_swap.sequence }
#     end

#     assert_redirected_to game_swap_path(assigns(:game_swap))
#   end

#   test "should show game_swap" do
#     get :show, id: @game_swap
#     assert_response :success
#   end

#   test "should get edit" do
#     get :edit, id: @game_swap
#     assert_response :success
#   end

#   test "should update game_swap" do
#     patch :update, id: @game_swap, game_swap: { a_to_b_id: @game_swap.a_to_b_id, b_to_a_id: @game_swap.b_to_a_id, game_id: @game_swap.game_id, round_id: @game_swap.round_id, sequence: @game_swap.sequence }
#     assert_redirected_to game_swap_path(assigns(:game_swap))
#   end

#   test "should destroy game_swap" do
#     assert_difference('GameSwap.count', -1) do
#       delete :destroy, id: @game_swap
#     end

#     assert_redirected_to game_swaps_path
#   end
# end
