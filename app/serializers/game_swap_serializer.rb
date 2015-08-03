class GameSwapSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :round_id, :sequence, :a_to_b_id, :b_to_a_id
end
