require 'test_helper'

class DeckCardTest < ActiveSupport::TestCase

  test "belongs to card" do
    assert_respond_to deck_cards(:one), :card
  end

  test "belongs to deck" do
    assert_respond_to deck_cards(:one), :deck
  end

end
