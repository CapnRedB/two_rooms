require 'test_helper'

class DeckTest < ActiveSupport::TestCase

  test "belongs to user" do
    assert_respond_to decks(:one), :user
  end

  test "has_many cards" do
    assert_respond_to decks(:one), :deck_cards
  end

  test "has user name" do
    assert_not_nil decks(:one).user_name, "user_name should not be blank, even if it's Anonymous"
  end

  test "has name" do
    assert decks(:two).save, "deck with name saves"
    blank = Deck.new
    assert_not blank.save, "name required"
  end

  test "name is unique" do
    assert decks(:two).save
    assert_not Deck.new(name: "Standard", user_id: decks(:two).user_id).save, "Duplicate name fails to save"
    assert Deck.new(name: "Standard2", user_id: decks(:two).user_id).save, "Unique name saves"
  end

  test "name is scoped to user" do
    assert decks(:two).save
    assert Deck.new(name: "Standard", user_id: 1).save, "Different users can use the same name"
  end


  test "adds default cards" do
    deck = Deck.new name: "Unique name"
    assert_equal deck.deck_cards.count, 0, "New deck has no cards"
    assert deck.save, "Deck should save"
    assert_equal deck.deck_cards.count, 5, "Saved deck has 5 cards"
  end

  test "default does not throw warnings" do
    assert decks(:one).save
    assert_nil decks(:one).warnings
  end

  test "warns imbalanced required" do
    decks(:one).deck_cards << DeckCard.new(card: cards(:red_spy), affiliation: "required")
    assert_not_nil decks(:one).warnings
    assert decks(:one).warnings.match(/required blue cards than/), "Should say more blue cards than red"
  end

  test "warns imbalanced no_bury" do
    decks(:one).deck_cards << DeckCard.new(card: cards(:red_shy), affiliation: "no_bury")
    assert_not_nil decks(:one).warnings
    assert decks(:one).warnings.match(/no_bury red cards than/), "Should say more red cards than blue"
  end

  # test "warns imbalanced if_bury" do
  # end

  test "warns imbalanced filler" do
    decks(:one).deck_cards << DeckCard.new(card: cards(:red_shy), affiliation: "filler")
    assert_not_nil decks(:one).warnings
    assert decks(:one).warnings.match(/filler red cards than/), "Should say more red cards than blue"
  end

  test "warns imbalanced parity" do
    decks(:one).deck_cards << DeckCard.new(card: cards(:red_shy), affiliation: "parity")
    assert_not_nil decks(:one).warnings
    assert decks(:one).warnings.match(/parity red cards than/), "Should say more red cards than blue"
  end
end
