class GamePlayer < ActiveRecord::Base

  belongs_to :game
  belongs_to :player, class_name: "User", foreign_key: :user_id
  belongs_to :card
  belongs_to :voting_for, class_name: "GamePlayer"

  has_many :swap_a_to_bs, class_name: "GameSwap", foreign_key: :a_to_b_id 
  has_many :swap_b_to_as, class_name: "GameSwap", foreign_key: :b_to_a_id 
end
