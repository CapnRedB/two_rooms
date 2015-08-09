class Swap < ActiveRecord::Base
  belongs_to :round
  
  default_scope { order "round_id ASC, player_min ASC"}


  def range
    unless player_max.blank?
      "#{player_min} - #{player_max}"
    else
      "#{player_min} +"
    end
  end

  def include?(count)
    player_min <= count and (! player_max or count <= player_max)
  end
end
