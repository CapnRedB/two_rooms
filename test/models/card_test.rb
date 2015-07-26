require 'test_helper'

class CardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save without a title" do
    card = Card.new faction: "Red"
    assert_not card.save, "Card saved without a title"
    card.title = "Coy Boy"
    assert card.save, "Card did not save when it should have"
  end

  test "should not save without a faction" do
    card = Card.new title: "Shy Guy"
    assert_not card.save, "Card saved without a faction"
    card.faction = "Blue"
    assert card.save, "Card did not save when it should have"
  end

  test "title is unique, scoped by color" do
    cards(:president).save
    card = Card.new title: "President", faction: "Blue"
    assert_not card.save, "Duplicate title on the same faction"

    cards(:red_spy).save
    card = Card.new title: "Spy", faction: "Blue"
    assert card.save, "Different factions can have the same title"
  end

  test "should have a team" do
    assert_not_nil cards(:president).team
  end

  test "should have an icon" do
    assert_not_nil cards(:red_spy).icon
  end
end
