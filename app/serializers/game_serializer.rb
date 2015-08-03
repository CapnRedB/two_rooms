class GameSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :deck_id, :game_type, :status, :outcome, :code
end
