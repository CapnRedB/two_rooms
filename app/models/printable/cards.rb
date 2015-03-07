require 'printable'

module Printable
	class Cards < Base

    CardOffsets = { 
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

    CardSize = {
      width: 62.mm,
      height: 88.mm
    }.freeze 

    def initialize()
      super
      @card_number = 0
      @current_color = "Blue"
    end

    def render(set)
      #set = []
      super() do
        # @card_number = 0
        set.each do |card|
          card.quantity.times do
            render_card card
          end
        end
      end
    end

    def render_card(card)
      if card.color != @current_color
        @card_number = (@card_number / 9.0).ceil * 9
      end

      pos = (@card_number % 9)
      row = pos / 3
      col = @card_number % 3

      offset = Printable::Cards::CardOffsets[pos]

      if @card_number != 0 and pos % 9 == 0  
        @pdf.start_new_page
      end


      @pdf.bounding_box(offset, Printable::Cards::CardSize) do
        card.render @pdf
      end

      @current_color = card.color
      @card_number += 1
    end
	end

  # module Cardable

  #   # def quantity
  #   #   instance_variable_get(:@quantity) || 1
  #   # end

  #   # def render(pdf)
  #   # end
  # end
end