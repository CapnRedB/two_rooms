class DeckSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :description, :bury, :user_name #, :warnings

  has_many :deck_cards

  def deck_cards
    object.deck_cards.sort{|a,b| a.card.sort_order <=> b.card.sort_order }
  end
end
