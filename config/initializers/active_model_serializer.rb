ActiveModel::Serializer.setup do |config|
  #config.adapter = :json
  config.embed = :ids
  config.embed_in_root = true
end
