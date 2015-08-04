require 'test_helper'

class GameLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "belongs to game" do
    assert_respond_to game_logs(:one), :game, "Belongs to a game"
  end
  

  test "should be ordered by created desc" do
    10.times do |i|
      GameLog.create game: games(:one), event: "Event #{i}", command: "COMMAND", description: "Description"
    end

    journal = games(:one).logs

    prev = DateTime.now
    journal.each do |log|
      assert prev >= log.created_at, "Should be descending ctime"
      prev = log.created_at
    end
  end
end
