class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :subtitle, :short_desc, :long_desc,
             :color, :faction, :strategy, :required_text, :recommended_text,
             :team, :large_icon, :text_id

#   has_many :relationships, :class_name => "CardRelationship", :foreign_key => "card_id"
# #  has_many :relations, :through => :relationships, :source => :to
#   has_many :inverse_relationships, :class_name => "CardRelationship", :foreign_key => "to_id"
# #  has_many :inverse_relations, :through => :inverse_relationships, :source => :card


  def text_id
    "#{title} (#{color})"
  end
end
