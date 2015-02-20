json.array!(@rounds) do |round|
  json.extract! round, :id, :game_type, :number, :duration
  json.url round_url(round, format: :json)
end
