class DeckCardSerializer < ActiveModel::Serializer
  attributes :id, :card, :affiliation #:card_id, :title, :color, :faction, :team, :affiliation


  has_one :card

  # def title
  #   object.card.title unless object.card.nil?
  # end

  # def color
  #   object.card.color unless object.card.nil?
  # end

  # def faction
  #   object.card.faction unless object.card.nil?
  # end

  # def team
  #   object.card.team unless object.card.nil?
  # end

end
