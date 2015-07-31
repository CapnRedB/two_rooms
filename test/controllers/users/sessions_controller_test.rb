require 'test_helper'

class Users::SessionsControllerTest < ActionController::TestCase
  setup do
    @user = users(:joe)
  end

  test "tautology" do
    assert_not @controller.current_user
    logged_in 
    assert @controller.current_user
  end


  test "should log in" do
    for_users

    users(:joe).password = "pa$$word"
    users(:joe).save

    assert_not @controller.current_user
    post :create, format: :json, user: { email: "joe@example.com", password: "pa$$word"}
    assert @controller.current_user
    assert_equal @controller.current_user, users(:joe)
  end

  test "should log out" do
    for_users

    logged_in
    assert @controller.current_user
    assert_equal @controller.current_user, users(:joe)

    delete :destroy, format: :json
    assert_not @controller.current_user
  end

  test "lets you know if you're not logged in" do
    for_users

    assert_not @controller.current_user

    #should tell you you're not logged in
    get :show, format: :json
    assert_response :unauthorized, "you should not be logged in"
  end

  test "lets you know if you're logged in" do
    for_users
    users(:joe).save

    logged_in
    assert @controller.current_user
    assert_equal @controller.current_user, users(:joe)

    get :show, format: :json

    assert JSON.parse(@response.body)
    body = JSON.parse(@response.body)

    assert body["token"], "Response should contain a token"
    assert_equal body["token"], users(:joe).authentication_token, "Token should match"

    assert body["email"], "Response should contain an email"
    assert_equal body["email"], users(:joe).email, "email should match"

    assert body["name"], "Response should contain a name"
    assert_equal body["name"], users(:joe).name, "name should match"

    assert body["user_id"], "Response should contain an id"
    assert_equal body["user_id"], users(:joe).id, "id should match"

  end

end
