json.array!(@cards) do |card|
  json.extract! card, :id, :title, :subtitle, :short_desc, :long_desc, :color, :faction, :strategy, :url
  json.url card_url(card, format: :json)
end
