require 'prawn'
require 'prawn/measurement_extensions'

class Cardset
  attr_accessor :cards

  CARD_OFFSETS = { 
    0 => [   0.mm, 264.mm],
    1 => [  62.mm, 264.mm],
    2 => [ 124.mm, 264.mm],
    3 => [   0.mm, 176.mm],
    4 => [  62.mm, 176.mm],
    5 => [ 124.mm, 176.mm],
    6 => [   0.mm,  88.mm],
    7 => [  62.mm,  88.mm],
    8 => [ 124.mm,  88.mm]
  }.freeze

  OFFSETS = {
    icon:        {at: [ 20.mm, 85.mm], width: 64, height: 64, align: :center},
    title:       {at: [ 2.mm, 55.mm], width: 58.mm, height: 10.mm, align: :center},
    subtitle:    {at: [ 2.mm, 50.mm], width: 58.mm, height: 10.mm, align: :center},
    description: {at: [ 2.mm, 45.mm], width: 58.mm, height: 20.mm, align: :center},
  }.freeze

  CARD_SIZE = {
    width: 62.mm,
    height: 88.mm
  }.freeze

  def self.all
    cardset = self.new
    cardset.cards = Card.all

    cardset
  end

  def render
    @pdf = Prawn::Document.new
    @cards.each_with_index do |card, idx|
      pos = (idx % 9)
      row = pos / 3
      col = idx % 3
      offset = Cardset::CARD_OFFSETS[pos]

      if idx != 0 and pos % 9 == 0 
        @pdf.start_new_page
      end

      @pdf.bounding_box(offset, Cardset::CARD_SIZE) do
        @pdf.transparent(0.5) { @pdf.stroke_bounds }
        # @pdf.text "#{offset[0]}, #{offset[1]}"
        # @pdf.text card.title

        @pdf.font("Helvetica", style: :bold, size: 16) do
          @pdf.text_box card.title, Cardset::OFFSETS[:title]
        end
        @pdf.font("Helvetica", style: :italic, size: 10) do
          @pdf.text_box card.subtitle, Cardset::OFFSETS[:subtitle]
        end
        @pdf.font("Courier", size: 8) do
          @pdf.text_box card.short_desc, Cardset::OFFSETS[:description]
        end

        @pdf.image "#{Rails.root.join('public')}/#{card.print_icon}", Cardset::OFFSETS[:icon]
      end

    end
    @pdf.render
  end
end