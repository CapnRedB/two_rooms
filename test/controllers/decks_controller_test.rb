# require 'test_helper'

class DecksControllerTest < ActionController::TestCase
  setup do
    @deck = decks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:decks)
  end

  test "index should respond with json" do 
    get :index, format: :json
    assert_response :success
    assert JSON.parse(@response.body)
  end

  test "decks.json should contain decks and not deck cards" do 
    get :index, format: :json
    assert_response :success

    body = JSON.parse(@response.body)
    assert body["decks"], "Response should contain decks"
    assert_not body["deck_cards"], "Response should not contain deck_cards"
    assert_not body["cards"], "Response should not contain cards"
  end

  test "show should respond with json" do
    get :show, id: @deck, format: :json
    assert_response :success
    assert JSON.parse(@response.body)
  end

  test "show.json should include deck and deck cards" do
    get :show, id: @deck, format: :json
    assert_response :success

    body = JSON.parse(@response.body)
    assert body["deck"], "Response should contain a deck"
    assert body["deck_cards"], "Response should contain deck cards" 
  end

  test "post decks.json should require logged in" do
    assert_throws(:warden) do
      post :create, deck: { name: "Standard Two" }, format: :json
    end
  end

  test "post decks.json should add a new deck" do
    logged_in
    assert_difference('Deck.count') do
      post :create, deck: { name: "Standard Two" }, format: :json
    end
    assert JSON.parse(@response.body)

    body = JSON.parse(@response.body)
    assert body["deck"], "Response should contain the new deck"
    assert body["deck_cards"], "Response should contain deck cards"
    assert_equal body["deck_cards"].count, 5, "New deck should contain the default deck cards"
    assert body["cards"], "Response should contain cards"
    assert_equal body["deck_cards"].count, 5, "New deck should contain the default deck cards"
  end

  test "post decks.json should reject missing name" do
    logged_in
    assert_no_difference('Deck.count') do 
      post :create, deck: { description: "Awesome new deck"}, format: :json
    end
    body = JSON.parse(@response.body)
    assert body["errors"], "Should kick an error"
    assert_equal body["errors"]["name"].first, "can't be blank", "Name can't be blank"
  end

  test "post decks.json should reject duplicate names" do
    logged_in
    decks(:one).save
    assert_no_difference('Deck.count') do 
      post :create, deck: { name: "Basic", user_id: 1}, format: :json
    end
    body = JSON.parse(@response.body)
    assert body["errors"], "Should kick an error"
    assert_equal body["errors"]["name"].first, "Duplicate deck name.", "Name must be unique"
  end

  test "cannot update another's deck" do
    decks(:two).save

    logged_in
    #assert_response(:unauthorized) do
    put :update, format: :json, id: decks(:two).id, deck: { name: "Standard 2"}

    assert_response(:unauthorized, "Should not be able to edit another user's deck")
    body = JSON.parse(@response.body)
    assert_not_equal body["deck"]["name"], "Standard 2", "Name should not have been updated"
  end

  test "put deck/1.json should update" do
    logged_in
    decks(:one).save

    put :update, format: :json, id: decks(:one).id, deck: {name: "Basic 2"}

    assert_response(:ok, "Should be able to change your own deck")

    body = JSON.parse(@response.body)
    assert_equal body["deck"]["name"], "Basic 2", "Should be updated in the response"
    assert_equal Deck.find(decks(:one).id).name, "Basic 2", "Should be updated in the database"

  end

  test "put deck/1.json should reject missing name" do
    logged_in
    decks(:one).save

    put :update, format: :json, id: decks(:one).id, deck: {name: "", burn: true}

    assert_response(:unprocessable_entity, "Deck must have a name")

    assert_equal Deck.find(decks(:one).id).name, "Basic", "Should be unchanged in the database"
    body = JSON.parse(@response.body)
    assert body["errors"], "Should kick an error"
    assert_equal body["errors"]["name"].first, "can't be blank", "Name cant be blank"
  end

  test "put deck/1.json should reject duplicate names" do
    decks(:two).user_id = decks(:one).user_id
    decks(:two).save

    logged_in
    decks(:one).save

    put :update, format: :json, id: decks(:one).id, deck: {name: "Standard", burn: true}

    assert_response(:unprocessable_entity, "Deck must have a name")

    assert_equal Deck.find(decks(:one).id).name, "Basic", "Should be unchanged in the database"
    body = JSON.parse(@response.body)
    assert body["errors"], "Should kick an error"
    assert_equal body["errors"]["name"].first, "Duplicate deck name.", "Name must be unique"
  end

  test "delete deck/1.json should delete" do
    decks(:one).save
    logged_in
    assert_difference('Deck.count', -1) do
      delete :destroy, format: :json, id: decks(:one).id
    end

    assert @response.body.blank?, "Should respond with nada"
  end

  test "cannot delete others decks" do
    decks(:two).save
    logged_in

    assert_no_difference('Deck.count', "Cannot delete another's deck") do
      delete :destroy, format: :json, id: decks(:two).id
    end
  end

end
