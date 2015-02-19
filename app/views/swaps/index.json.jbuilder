json.array!(@swaps) do |swap|
  json.extract! swap, :id, :round_id, :player_min, :player_max, :count
  json.url swap_url(swap, format: :json)
end
