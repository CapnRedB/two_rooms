class GameSwap < ActiveRecord::Base

  belongs_to :game
  belongs_to :round

  belongs_to :a_to_b, class_name: "GamePlayer"
  belongs_to :b_to_a, class_name: "GamePlayer"
end
