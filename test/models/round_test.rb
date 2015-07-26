require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "uniqueness" do
    round = Round.new
    round.game_type = "Basic"
    round.number = 1
    assert ! round.save, "Duplicate round saved without errors"

    round.number = 4
    assert round.save, "Round number scoped by type"
  end  

  test "default ordering" do
    rounds = Round.all
    cur_type = "ZZ"
    cur_num = 0

    rounds.each do |r|
      assert r.game_type <= cur_type, "Type not in descending order"
      if r.game_type < cur_type
        cur_type = r.game_type
        cur_num = 0
      end

      assert r.number > cur_num, "Round# is not in ascending order"
      cur_num = r.number
    end
  end
 
  test "duration" do
    round = Round.new
    round.duration = 1
    assert_equal round.duration_with_unit, "1 minute", "Duration singular"

    round.duration = 2
    assert_equal round.duration_with_unit, "2 minutes", "Duration plural"
  end

  test "title" do
    round = Round.offset(rand(Round.count)).first
    Round.all.each do |r|
      assert r.title.match(/(Basic|Advanced) - Round [0-9]/), "Title format mismatch: #{r.title}"
    end
  end

end
