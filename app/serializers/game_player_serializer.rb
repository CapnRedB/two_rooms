class GamePlayerSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :user_id, :card_id, :name, :location, :leader, :voting_for_id

  def name
    if object.player and object.player.name
      object.player.name
    else
      "Anonymous"
    end
  end

end
