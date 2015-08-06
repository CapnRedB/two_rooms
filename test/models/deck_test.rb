require 'test_helper'

class DeckTest < ActiveSupport::TestCase

  test "belongs to user" do
    assert_respond_to decks(:one), :user, "Should belong to user"
  end

  test "has_many cards" do
    assert_respond_to decks(:one), :deck_cards, "Should have cards"
  end

  test "has_many games" do
    assert_respond_to decks(:one), :games, "Should have games"
  end

  test "has user name" do
    assert_not_nil decks(:one).user_name, "user_name should not be blank, even if it's Anonymous"
  end

  test "has name" do
    assert decks(:two).save, "deck with name saves"
    blank = Deck.new
    assert_not blank.save, "name required"
  end

  test "name is unique" do
    assert decks(:two).save
    assert_not Deck.new(name: "Standard", user_id: decks(:two).user_id).save, "Duplicate name fails to save"
    assert Deck.new(name: "Standard2", user_id: decks(:two).user_id).save, "Unique name saves"
  end

  test "name is scoped to user" do
    assert decks(:two).save
    assert Deck.new(name: "Standard", user_id: 1).save, "Different users can use the same name"
  end


  test "adds default cards" do
    deck = Deck.new name: "Unique name"
    assert_equal deck.deck_cards.count, 0, "New deck has no cards"
    assert deck.save, "Deck should save"
    assert_equal deck.deck_cards.count, 5, "Saved deck has 5 cards"
  end

  test "default does not throw warnings" do
    assert decks(:one).save
    assert_nil decks(:one).warnings
  end

  test "warns imbalanced required" do
    decks(:one).deck_cards << DeckCard.new(card: cards(:red_spy), affiliation: "required")
    assert_not_nil decks(:one).warnings
    assert decks(:one).warnings.match(/required blue cards than/), "Should say more blue cards than red"
  end

  test "warns imbalanced no_bury" do
    decks(:one).deck_cards << DeckCard.new(card: cards(:red_shy), affiliation: "no_bury")
    assert_not_nil decks(:one).warnings
    assert decks(:one).warnings.match(/no_bury red cards than/), "Should say more red cards than blue"
  end

  # test "warns imbalanced if_bury" do
  # end

  test "warns imbalanced filler" do
    decks(:one).deck_cards << DeckCard.new(card: cards(:red_shy), affiliation: "filler")
    assert_not_nil decks(:one).warnings
    assert decks(:one).warnings.match(/filler red cards than/), "Should say more red cards than blue"
  end

  test "warns imbalanced parity" do
    decks(:one).deck_cards << DeckCard.new(card: cards(:red_shy), affiliation: "parity")
    assert_not_nil decks(:one).warnings
    assert decks(:one).warnings.match(/parity red cards than/), "Should say more red cards than blue"
  end

  test "generates a set of cards" do
    d = decks(:basic)
    2.upto(18) do |n|
      card_set = d.generate(n)
      assert card_set[:cards], "Should generate a hash with a key of cards"
      assert_equal n, card_set[:cards].count, "Generates appropriate number of cards"
      grouped = card_set[:cards].group_by(&:title)

      assert_equal 1, grouped["President"].count, "Should have one president"
      assert_equal 1, grouped["Bomber"].count, "Should have one bomber"
      if n % 2 == 1
        assert_equal n % 2, grouped["Gambler"].count, "Should have gambler if odd parity"
      end
      if n > 3
        assert_equal ((n - 2) / 2).floor, grouped["Red Team"].count, "Should have n-2/2 Red team cards"
        assert_equal ((n - 2) / 2).floor, grouped["Blue Team"].count, "Should have n-2/2 Blue team cards"
      end
    end
  end

  test "generates with bury" do
    d = decks(:basic_bury)
    4.upto(18) do |n|
      card_set = d.generate(n, bury: true)
      assert card_set[:cards], "Should generate a hash with a key of cards"
      assert card_set[:buryable], "Should generate a hash with a key of cards"
      assert card_set[:buried], "Should bury a card"

      assert_equal n, card_set[:cards].count, "Generates appropriate number of cards"
      assert_equal n+1, card_set[:buryable].count, "Generates appropriate number of buryable cards"
      grouped = card_set[:buryable].group_by(&:title)

      assert_equal 1, grouped["President"].count, "Should have one president"
      assert_equal 1, grouped["Vice President"].count, "Should have one vp"
      assert_equal 1, grouped["Bomber"].count, "Should have one bomber"
      assert_equal 1, grouped["Martyr"].count, "Should have one martyr"
      if n % 2 == 0
        assert_equal 1, grouped["Gambler"].count, "Should have gambler if even parity"
      end
      if n > 5
        # n - four required cards + the extra card that'll be buried / 2
        assert_equal ((n - 4 + 1) / 2).floor, grouped["Red Team"].count, "Should have n-4/2 Red team cards"
        assert_equal ((n - 4 + 1) / 2).floor, grouped["Blue Team"].count, "Should have n-4/2 Blue team cards"
      end
    end
  end

  test "respects no_bury" do
    d = decks(:advanced_bury)
    #d.deck_cards.collect{|dc| puts "#{dc.affiliation}: #{dc.card.title}" }
    7.upto(18) do |n|
      card_set = d.generate(n, bury: true)
      assert card_set[:cards], "Should generate a hash with a key of cards"
      assert card_set[:buryable], "Should generate a hash with a key of cards"
      assert card_set[:buried], "Should bury a card"

      assert_equal n, card_set[:cards].count, "Generates appropriate number of cards"
      assert_equal n - 3 + 1, card_set[:buryable].count, "Generates appropriate number of buryable cards"
      grouped = card_set[:buryable].group_by(&:title)

      assert_equal 1, grouped["President"].count, "Should have one president"
      assert_equal 1, grouped["Vice President"].count, "Should have one vp"
      assert_equal 1, grouped["Bomber"].count, "Should have one bomber"
      assert_equal 1, grouped["Martyr"].count, "Should have one martyr"

      if n % 2 == 1
        assert_equal 1, grouped["Gambler"].count, "Should have gambler if even parity"
      end
      if n > 8
        # n - four required cards - 3 no_burys + the extra card that'll be buried / 2
        assert_equal ((n - 4 - 3 + 1) / 2).floor, grouped["Red Team"].count, "Should have n-7/2 Red team cards"
        assert_equal ((n - 4 - 3 + 1) / 2).floor, grouped["Blue Team"].count, "Should have n-7/2 Blue team cards"
      end

      grouped_cards = card_set[:cards].group_by(&:title)
      assert_equal 1, grouped_cards["Sniper"].count, "Actual deck must contain Sniper"
      assert_equal 1, grouped_cards["Decoy"].count, "Actual deck must contain Decoy"
      assert_equal 1, grouped_cards["Target"].count, "Actual deck must contain Target"
    end

  end

  test "complains if under minimum" do
    d = decks(:basic)
    0.upto(1) do |n|
      assert_raises(Deck::NotEnoughPlayersError) do
        card_set = d.generate(n)
      end
    end
    d = decks(:basic_bury)
    0.upto(3) do |n|
      assert_raises(Deck::NotEnoughPlayersError) do
        card_set = d.generate(n)
      end
    end
  end

  test "complains if cant match exact count" do
    #fixed size deck
    d = decks(:adulterous_whale)
    0.upto(5) do |n|
      assert_raises(Deck::NotEnoughPlayersError) do
        card_set = d.generate(n)
      end
    end
    card_set = d.generate(6)
    assert card_set[:cards], "Should generate cards"
    assert_equal 6, card_set[:cards].count, "Should generate 6 cards"
    7.upto(18) do |n|
      assert_raises(Deck::UnsupportedPlayerCountError) do
        card_set = d.generate(n)
      end
    end
  end

  test "complains if cant match count because of missing parity" do

    # a deck without a parity card only supports odd (or even) counts
    d = decks(:no_parity)
    0.upto(1) do |n|
      assert_raises(Deck::NotEnoughPlayersError) do
        card_set = d.generate(n, bury: false)
      end
      assert_raises(Deck::NotEnoughPlayersError) do
        card_set = d.generate(n, bury: true)
      end
    end
    
    assert_nothing_raised("Should work at two, no bury") do
      card_set = d.generate(2, bury: false)
    end

    2.upto(3) do |n|
      assert_raises(Deck::NotEnoughPlayersError) do
        card_set = d.generate(n, bury: true)
      end
    end

    4.upto(18) do |n|
      if n % 2 == 0
        assert_nothing_raised("Should work at n%2 == 0") do
          card_set = d.generate(n, bury: false)
        end
        assert_raises(Deck::UnsupportedPlayerCountError) do
          card_set = d.generate(n, bury: true)
        end
      else
        assert_raises(Deck::UnsupportedPlayerCountError) do
          card_set = d.generate(n, bury: false)
        end
        assert_nothing_raised("Should work at n%2 == 1 when burying") do
          card_set = d.generate(n, bury: true)
        end
      end
    end

  end

  test "complains if cant match because of filler count" do

    #a deck with three filler cards only supports m + k*3 counts
    d = decks(:three_filler)
    0.upto(2) do |n|
      assert_raises(Deck::NotEnoughPlayersError) do
        card_set = d.generate(n)
      end
    end
    3.upto(18) do |n|
      if n % 3 == 0
        assert_nothing_raised("Should work at n % 3 == 0") do
          card_set = d.generate(n)
        end
      else
        assert_raises(Deck::UnsupportedPlayerCountError) do
          card_set = d.generate(n)
        end        
      end
    end
  end

  test "complains trying to bury in a deck not configured to bury" do
    d = decks(:basic)
    2.upto(18) do |n|
      assert_raises(Deck::UnableToBuryError) do
        card_set = d.generate(n, bury: true)
      end
    end
  end

end
