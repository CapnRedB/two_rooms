class CardRelationship < ActiveRecord::Base
  belongs_to :card
  belongs_to :to, :class_name => "Card"
end
