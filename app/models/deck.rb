class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :deck_cards
  after_create :add_default_cards!

  validates :name, uniqueness: { scope: :user_id, message: "Duplicate deck name." }

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


  def warnings
    warnings = []

    red_counts = {}
    blue_counts = {}

    ["required", "no_bury", "filler", "parity"].each do |affiliation|
      red_counts[affiliation] = deck_cards.select{|dc| dc.card.color == 'Red' and dc.affiliation == affiliation}.count
      blue_counts[affiliation] = deck_cards.select{|dc| dc.card.color == 'Blue' and dc.affiliation == affiliation}.count

      case red_counts[affiliation] <=> blue_counts[affiliation]
      when -1
        warnings << "This deck has more #{affiliation} blue cards than #{affiliation} red cards. "
      when 1
        warnings << "This deck has more #{affiliation} red cards than #{affiliation} blue cards. "
      end
    end

    if warnings.empty?
      nil
    else
      #{}"<ul><li>" + warnings.join("</li><li>") + "</li></ul>"
      warnings.join()
    end
  end
  
end
