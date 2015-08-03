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

  # test "param is code" do
  #   games(:one).save
  #   assert_equal games(:one).to_param, games(:one).code, "Param should be code, not id"
  #   assert_not_equal games(:one).to_param, games(:one).id, "Param should not be id"
  # end

  test "adds self to game on create" do
    g = Game.new user: users(:joe)
    assert g.save, "Game should save"
    assert_equal g.game_players.count, 1, "Game should have one player on create"
    assert_equal g.game_players.first.player, users(:joe), "The player should be the user who created the game"
  end

  ###slow test
  # test "code length increases and does not contain hard to read chars" do
  #   prev = 0
  #   10000.times do |n|
  #     g = Game.new
  #     g.save

  #     if n % 257 == 0
  #       assert g.code.length >= prev, "Code length should be >= to previous length"
  #       prev = g.code.length

  #       g.code.each_char do |char|
  #         assert_not "il10o8B3Evumnr".include?(char), "Code #{g.code} includes hard to read char"
  #       end
  #     end
  #   end
  # end
end
