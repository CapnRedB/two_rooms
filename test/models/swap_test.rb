require 'test_helper'

class SwapTest < ActiveSupport::TestCase

  test "belongs to round" do
    assert_respond_to swaps(:one), :round
  end

  test "formats a range" do
    swap = Swap.new player_min: 2, player_max: 5
    assert_equal swap.range, "2 - 5"
  end

  test "range has a plus if max is blank" do
    assert_nil swaps(:three).player_max, "Player max is present"
    assert swaps(:three).range.match(/\+/), "Range contains a plus"
  end

  # test "range does not overlap" do
  # end

  # test "range does not have gaps" do
  # end

  test "sorts by round_id, then range ascending" do
    round_id = 0
    cur = -1
    Swap.all.each do |s|
      if s.round_id > round_id
        round_id = s.round_id
        cur = s.player_min
      else
        assert s.player_min > cur, "Swap #{s.id} #{s.player_min} !> #{cur}"
        cur = s.player_min
      end
    end
  end  

  test "it can tell if a count is included in its range" do
    assert_not swaps(:three).include? 21
    assert swaps(:three).include? 20000

    assert_not swaps(:two).include? 0
    assert_not swaps(:two).include? 6
    assert swaps(:two).include? 7
    assert swaps(:two).include? 14
    assert swaps(:two).include? 21
    assert_not swaps(:two).include? 22
  end

end
