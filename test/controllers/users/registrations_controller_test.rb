require 'test_helper'

class Users::RegistrationsControllerTest < ActionController::TestCase
  setup do
    @user = users(:joe)
  end

  test "users can sign up" do
    for_users

    assert_difference("User.count", 1, "Should be another user") do
      post :create, format: :json, user: { name: "Joe", email: "joflynn@example.com", password: "bananas1" }
    end

    body = JSON.parse(@response.body)
    new_user = User.find(body["user_id"])
    assert_equal body["name"], new_user.name, "Name should have saved"
    assert_equal body["email"], new_user.email, "Email should have saved"
    assert_equal body["token"], new_user.authentication_token, "Token should be right"
  end

  test "must be logged in to edit" do
    users(:joe).save
    for_users
    put :update, format: :json, user: { user_id: users(:joe).id, name: "Jose"}

    body = JSON.parse(@response.body)
    assert_response :unauthorized, "Shouldn't be allowed to edit user without being logged in"
    assert body["error"], "should kick an error"
    assert body["error"].match(/sign in or sign up/), "Should require login"
  end

###i think this belongs in local users controller, not registrations
  # test "Users can edit their name" do
  #   users(:joe).save
  #   logged_in

  #   put :update, format: :json, user: { name: "Jose"}

  #   body = JSON.parse(@response.body)
  #   assert_response :ok, "Should be allowed to change your name"
  #   p body
  # end

  # test "email is unique" do
  # end

  # test "name is unique" do
  # end

  test "validates password requirements" do 
    for_users
    post :create, format: :json, user: { name: "Joe", email: "joflynn@example.com", password: "bananas" }

    body = JSON.parse(@response.body)
    assert_response :not_acceptable, "Shouldn't let you sign up"
    assert body["errors"], "kicked errors"
    assert_equal body["errors"]["password"][0], "is too short (minimum is 8 characters)", "Password is too short"
  end
end
# POST/PATCH /users/json #create #update