class DeckSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :bury, :user_name
end
