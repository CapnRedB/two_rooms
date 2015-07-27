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

  test "sorts by range ascending" do
    cur = 0
    Swap.all.each do |s|
      assert s.player_min > cur
      cur = s.player_min
    end
  end  
end
