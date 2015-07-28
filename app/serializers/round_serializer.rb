class RoundSerializer < ActiveModel::Serializer
  attributes :id, :game_type, :number, :duration

  has_many :swaps

end
