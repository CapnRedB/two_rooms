class GameSwap < ActiveRecord::Base

  belongs_to :game
  belongs_to :round

  belongs_to :a_to_b, class_name: "GamePlayer"
  belongs_to :b_to_a, class_name: "GamePlayer"


  def done?
    a_to_b_id and b_to_a_id and a_to_b_id != b_to_a_id
  end
end
