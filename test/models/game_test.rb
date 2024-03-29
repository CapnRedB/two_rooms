require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "has_many game players" do
    assert_respond_to games(:one), :game_players, "Game should have players"
  end

  test "has_many swaps" do
    assert_respond_to games(:one), :game_swaps, "Game should have swaps"
  end

  test "belongs to a deck" do
    assert_respond_to games(:one), :deck, "Game should have a deck"
  end

  test "belongs to a user" do
    assert_respond_to games(:one), :user, "Game should have an owner"
  end

  test "generates a code" do
    games(:one).save

    assert games(:one).code, "Should generate a code when saved"
    assert games(:one).code.length >= 4, "Should be at least 4 chars long"

    assert_equal Game.where(code: games(:one).code).count, 1, "Code should be unique"
    assert games(:one).code.match(/^[a-z0-9]*$/), "Should only contain letters and numbers #{games(:one).code}"
  end
end
