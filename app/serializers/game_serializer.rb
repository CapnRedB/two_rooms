class GameSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :deck_id, :game_type, :status, :outcome, :code, :created_at

  has_many :game_players
  has_many :game_swaps  
end
