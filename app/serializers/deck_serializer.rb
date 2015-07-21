class DeckSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :description, :bury, :user_name

  has_many :deck_cards
end
