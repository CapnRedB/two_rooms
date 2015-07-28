# require 'test_helper'

# class CardRelationshipsControllerTest < ActionController::TestCase
#   setup do
#     @card_relationship = card_relationships(:one)
#   end

#   test "should get index" do
#     get :index
#     assert_response :success
#     assert_not_nil assigns(:card_relationships)
#   end

#   test "should get new" do
#     get :new
#     assert_response :success
#   end

#   test "should create card_relationship" do
#     assert_difference('CardRelationship.count') do
#       post :create, card_relationship: { card_id: @card_relationship.card_id, description: @card_relationship.description, to_id: @card_relationship.to_id }
#     end

#     assert_redirected_to card_relationship_path(assigns(:card_relationship))
#   end

#   test "should show card_relationship" do
#     get :show, id: @card_relationship
#     assert_response :success
#   end

#   test "should get edit" do
#     get :edit, id: @card_relationship
#     assert_response :success
#   end

#   test "should update card_relationship" do
#     patch :update, id: @card_relationship, card_relationship: { card_id: @card_relationship.card_id, description: @card_relationship.description, to_id: @card_relationship.to_id }
#     assert_redirected_to card_relationship_path(assigns(:card_relationship))
#   end

#   test "should destroy card_relationship" do
#     assert_difference('CardRelationship.count', -1) do
#       delete :destroy, id: @card_relationship
#     end

#     assert_redirected_to card_relationships_path
#   end
# end
