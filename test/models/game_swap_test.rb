require 'test_helper'

class GameSwapTest < ActiveSupport::TestCase

  test "should belong to a game" do
    assert_respond_to game_swaps(:one), :game, "Should belong to a game"
  end

  test "belongs to a round" do
    assert_respond_to game_swaps(:one), :round, "Should belong to a round"
  end

  test "belongs to a_to_b" do
    assert_respond_to game_swaps(:one), :a_to_b, "Should have a player going from a to b"
  end

  test "belongs to b_to_a" do
    assert_respond_to game_swaps(:one), :b_to_a, "Should have a player going from b to a"
  end

end
