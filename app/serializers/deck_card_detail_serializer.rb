class DeckCardDetailSerializer < ActiveModel::Serializer
  attributes :id, :card_id, :title, :color, :faction, :team, :affiliation

  root :deck_card

  #has_one :card
  def title
    object.card.title unless object.card.nil?
  end

  def color
    object.card.color unless object.card.nil?
  end

  def faction
    object.card.faction unless object.card.nil?
  end

  def team
    object.card.team unless object.card.nil?
  end

  # def all_cards
  #   Card.unscoped.alpha.limit(10).all
  # end

end
