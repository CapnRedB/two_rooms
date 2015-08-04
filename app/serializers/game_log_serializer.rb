class GameLogSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :event, :command, :description
end
