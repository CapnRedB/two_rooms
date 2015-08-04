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

  test "it should only allow one player per user (per game)" do
    game = Game.new user: users(:sarah)
    game.save

    player_one = GamePlayer.new player: users(:joe)
    player_one.game = game
    assert player_one.save, "should be able to add once"

    player_two = GamePlayer.new player: users(:joe)
    player_two.game = game
    assert_not player_two.save, "should not be able to join again"
    assert player_two.errors, "Should kick errors"
  end

  test "adding a game player should touch the game" do
    game = Game.new user: users(:sarah)
    game.save

    before = game.updated_at
    player_one = GamePlayer.new player: users(:joe)
    player_one.game = game
    player_one.save

    assert before < game.updated_at, "Game mtime should be updated"

  end

  test "deleting a game player should touch the game" do
    game = Game.new user: users(:sarah)
    game.save

    before = game.updated_at
    sarah = game.game_players.first
    sarah.destroy

    assert before < game.updated_at, "Game mtime should be updated"

  end

end
