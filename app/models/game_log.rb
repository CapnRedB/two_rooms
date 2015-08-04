class GameLog < ActiveRecord::Base
  belongs_to :game
  
  default_scope { order("created_at desc") }  
end
