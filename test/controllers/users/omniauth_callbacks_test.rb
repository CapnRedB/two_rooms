require 'test_helper'

class Users::OmniauthCallbacksControllerTest < ActionController::TestCase
  setup do
    @user = users(:joe)
  end

  # test "redirects out" do
  #   for_users
  #   get :passthru, provider: :twitter

  #   p @response.body
  #   p @response.status
  # end

  # test "comes back" do
  #   for_users
  #   get :twitter

  #   p @response.body
  #   p @response.status
  # end
end

# /users/auth/:provider    #passthru
# /users/auth/:action/callback   #:action
