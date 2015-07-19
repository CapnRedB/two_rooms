json.array!(@decks) do |deck|
  json.extract! deck, :id, :user_id, :name, :description, :bury
  json.url deck_url(deck, format: :json)
end
