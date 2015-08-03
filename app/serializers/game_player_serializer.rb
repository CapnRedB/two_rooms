class GamePlayerSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :user_id, :card_id, :location, :leader, :voting_for_id
end
