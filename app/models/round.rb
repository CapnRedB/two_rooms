require 'printable/cards'
#require 'prawn/table'


class Round < ActiveRecord::Base
  Types = ["Basic", "Advanced"].freeze

  has_many :swaps

  default_scope { order "game_type DESC, number ASC"}

  validates :number, uniqueness: { scope: :game_type }

  def title
    "#{game_type} - Round #{number}"
  end

  def to_s
    title
  end

  include ActionView::Helpers::TextHelper
  def duration_with_unit
    pluralize(duration, "minute")
  end



  #for pdf creation

  Offsets = {
    duration: { at: [2.mm, 58.mm], width: 58.mm, height: 10.mm, align: :center },
    title:    { at: [2.mm, 55.mm], width: 58.mm, height: 10.mm, align: :center },
    swaps:    { at: [2.mm, 50.mm], width: 58.mm, height: 40.mm, align: :center }
  }.freeze 

  # include Printable::Cardable

  def self.render
    cards = Round.all
    cards << LeaderCard.new

    Printable::Cards.new.render(cards)
  end

  def quantity
    1
  end

  def render(document)
    # document.transparent(0.125) { document.stroke_bounds }

    document.font("Helvetica", style: :bold, size: 16) do
      document.text_box title, Round::Offsets[:title]
    end

    document.font("Helvetica", style: :italic, size: 10) do
      document.text_box duration_with_unit, Round::Offsets[:duration]
    end


    unless swaps.empty?
      document.bounding_box(Round::Offsets[:swaps][:at], Round::Offsets[:swaps]) do

        document.font("Courier", size: 8) do
          data = [ ["Players", "Hostages"] ]
          swaps.each do |swap|
            data << [swap.range , swap.count.to_s]
          end

          document.table(data, cell_style: {width: 29.mm }) do
          # document.table(data, position: :center) do
            cells.padding = 1
            cells.borders = []
            row(0).borders = [:bottom]
            row(0).style = :bold
            columns(0..1).align = :center
          end
        end


      end
    end

  end

end

class LeaderCard
  def quantity 
    1
  end
  def render(document)
    document.font("Helvetica", style: :bold, size: 40) do
      document.text_box "Leader", at: [2.mm, 55.mm], width: 58.mm, height: 20.mm, align: :center
    end
  end
end

