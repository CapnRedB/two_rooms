class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :deck_cards
  after_create :add_default_cards!

  def user_name
    unless user.nil?
      user.name
    else
      "Anonymous"
    end
  end


  def add_default_cards!
    { required: ["President", "Bomber"], filler: ["Blue Team", "Red Team"], parity: ["Gambler"]}.each do |affiliation, titles|
      titles.each do |title|
        dc = self.deck_cards.create
        dc.card = Card.find_by title: title
        if dc.card.nil?
          puts "Missing card #{title}"
        end
        dc.affiliation = affiliation
        dc.save
      end
    end
  end

end
