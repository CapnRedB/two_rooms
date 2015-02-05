class Card < ActiveRecord::Base
  COLORS = ["Blue", "Red", "Grey"].freeze
  FACTIONS = COLORS

  default_scope { order("id asc") }

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
      ""
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

end
