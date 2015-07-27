require 'test_helper'

class CardRelationshipTest < ActiveSupport::TestCase

  test "belongs to card" do
    assert_respond_to card_relationships(:one), :card
    assert_equal card_relationships(:one).card, cards(:president)
  end

  test "belongs to to (card)" do
    assert_respond_to card_relationships(:one), :to
    assert_equal card_relationships(:one).to, cards(:bomber)
  end


end
