class Swap < ActiveRecord::Base
  belongs_to :round
  
  default_scope { order "player_min ASC"}


  def range
    unless player_max.blank?
      "#{player_min} - #{player_max}"
    else
      "#{player_min} +"
    end
  end
end
