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
end
