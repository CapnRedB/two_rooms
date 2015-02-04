require 'prawn'

class Cardset
  attr_accessor :cards

  def self.all
    cardset = self.new
    cardset.cards = Card.all

    cardset
  end

  def render
    @pdf = Prawn::Document.new
    @cards.each do |card|
      @pdf.text card.title
    end
    @pdf.render
  end
end