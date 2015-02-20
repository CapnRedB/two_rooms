require 'printable/cards'

class Card < ActiveRecord::Base
  COLORS = ["Blue", "Red", "Grey"].freeze
  FACTIONS = COLORS

  default_scope { order("sort_order asc") }

  def team
    case faction
    when "Blue"
        "You are on the Blue Team"
    when "Red"
       "You are on the Red Team"
    else 
      "You are not on a team"
    end
  end

  def icon
    case faction
    when "Blue"
      "images/star.png"
    when "Red"
      "images/bomb.png"
    else
      nil
    end
  end

  def print_icon
    case faction
    when "Blue"
      "images/print-star.png"
    when "Red"
      "images/print-bomb.png"
    else
      ""
    end
  end

  def flip
    map = { 
      "Blue" => "Red",
      "Red" => "Blue",
      "Grey" => "Grey",
    }

    flipped = dup
    flipped.color = map[color]
    flipped.faction = map[faction]

    [:subtitle, :short_desc, :long_desc, :strategy].each do |field|

      val = flipped.send(field)

      # swap
      val.gsub!(/Blue/, "Cyan")
      val.gsub!(/Red/, "Blue")
      val.gsub!(/Cyan/, "Red")

      flipped.send("#{field}=", val)
    end

    flipped
  end



  Offsets = {
    icon:        {at: [ 20.mm, 64.mm], width:    64, height: 64, align: :center},
    title:       {at: [  2.mm, 55.mm], width: 58.mm, height: 10.mm, align: :center},
    subtitle:    {at: [  2.mm, 48.mm], width: 58.mm, height: 10.mm, align: :center},
    description: {at: [  2.mm, 40.mm], width: 58.mm, height: 20.mm, align: :center},
    color:       {at: [ 46.mm,  5.mm], width: 15.mm, height: 10.mm, align: :right},
  }.freeze

  # include Printable::Cardable

  #render the whole file
  def self.render
    Printable::Cards.new.render(Card.all)
  end

  # def quantity
  #   @quantity
  # end

  #render one card
  def render(document)
    # document.transparent(0.5) { document.stroke_bounds }

    if icon
      document.transparent(0.25) do
        document.image "#{Rails.root.join('public')}/#{print_icon}", Card::Offsets[:icon]
      end
    end

    document.font("Helvetica", style: :bold, size: 16) do
      document.text_box title.gsub(/`/, ""), Card::Offsets[:title]
    end
    document.font("Helvetica", style: :italic, size: 10) do
      document.text_box subtitle.gsub(/`/, ""), Card::Offsets[:subtitle]
    end
    document.font("Courier", size: 8) do
      document.text_box short_desc.gsub(/`/, ""), Card::Offsets[:description]
    end

    # document.font("Courier", size: 6) do
    #   document.text_box long_desc.gsub(/`/, ""), at: [2.mm, 25.mm], width: 58.mm, height: 25.mm, align: :justify
    # end

    # document.font("Helvetica", style: :bold, size: 12) do
    #   document.text_box color.gsub(/`/, ""), Card::Offsets[:color]
    # end

  end

end
