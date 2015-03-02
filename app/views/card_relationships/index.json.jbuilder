json.array!(@card_relationships) do |card_relationship|
  json.extract! card_relationship, :id, :card_id, :to_id, :description
  json.url card_relationship_url(card_relationship, format: :json)
end
