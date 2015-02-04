class Card < ActiveRecord::Base
  COLORS = ["Blue", "Red", "Grey"].freeze
  FACTIONS = COLORS

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
end
