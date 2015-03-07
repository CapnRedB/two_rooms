require 'printable/cards'

class Card < ActiveRecord::Base
  COLORS = ["Blue", "Red", "Grey"].freeze
  FACTIONS = COLORS

  default_scope { order("sort_order asc") }
  scope :alpha, -> { order("title asc, color asc") }
  scope :color, -> { order("color asc, title asc") }
  
  has_many :relationships, :class_name => "CardRelationship", :foreign_key => "card_id"
  has_many :relations, :through => :relationships, :source => :to
  has_many :inverse_relationships, :class_name => "CardRelationship", :foreign_key => "to_id"
  has_many :inverse_relations, :through => :inverse_relationships, :source => :card

  def relationships_grouped
    relationships.group_by(&:description)
  end

  def inverse_relationships_grouped
    inverse_relationships.group_by(&:description)
  end

  # def enemies
  #   relationships_grouped["Enemy"].collect(&:to) unless relationships_grouped["Enemy"].nil?
  # end

  # def enemies_of
  #   unless inverse_relationships_grouped["Enemy"].nil?
  #     enemies_of = inverse_relationships_grouped["Enemy"].collect(&:card)

  #     mutual = enemies
  #     unless mutual.nil?
  #       enemies_of.reject! { |enemy_of| mutual.include?(enemy_of) }
  #     end
  #     enemies_of
  #   end
  # end
  RelationshipTypes = { enemies: "Enemy", allies: "Ally", requires: "Required", recommends: "Recommended" }.freeze
  RelationshipTypes.each do |method, description|

    define_method(method.to_s) do 
      unless relationships_grouped[description].nil?
        relationships_grouped[description].collect(&:to)
      else
        []
      end
    end

    define_method(method.to_s + "_of") do
      unless inverse_relationships_grouped[description].nil?
        inverse = inverse_relationships_grouped[description].collect(&:card)

        mutual = send(method)
        unless mutual.nil?
          inverse.reject! { |inv| mutual.include? inv }
        end

        inverse
      else
        []
      end
    end
  end
  def required_by; requires_of; end
  def recommended_by; recommends_of; end

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

  def title_with_color
    "#{title} (#{color})"
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
