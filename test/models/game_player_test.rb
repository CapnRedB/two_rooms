require 'test_helper'

class GamePlayerTest < ActiveSupport::TestCase

  test "should belong to game" do
    assert_respond_to game_players(:one), :game, "Should belong to a game"
  end

  test "should belong to player" do
    assert_respond_to game_players(:one), :player, "Should belong to a player"
  end

  test "player is actually a user" do
    game_players(:one).player = users(:joe)
    game_players(:one).save
    assert_equal game_players(:one).player, users(:joe), "Player is a user"
  end

  test "should belong to card" do
    assert_respond_to game_players(:one), :card, "Should belong to a card"
  end

  test "should have voting_for " do
    assert_respond_to game_players(:one), :voting_for, "Should have a vote"
  end

  test "should be able to vote for another player" do
    assert_nothing_raised do
      game_players(:three).voting_for = game_players(:two)
    end
    assert_equal game_players(:three).voting_for_id, game_players(:two).id, "Should be pointing at :two"
  end

  test "should have many swap_a_to_bs" do
    assert_respond_to game_players(:one), :swap_a_to_bs, "Should have swaps from A to B"
  end

  test "should have many swap_b_to_as" do
    assert_respond_to game_players(:one), :swap_a_to_bs, "Should have swaps from B to A"
  end

end
