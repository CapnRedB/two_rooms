class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :games
  has_many :deck_cards
  after_create :add_default_cards!

  validates :name, presence: true
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
  

  def generate(player_count, options = {})
    options.reverse_merge! bury: bury
    raise(UnableToBuryError, "Deck not configured to bury a card") if options[:bury] and ! bury

    count = player_count
    count += 1 if options[:bury]

    card_sets = deck_cards.group_by(&:affiliation)

    cards = []
    no_burys = []
    no_burys = card_sets["no_bury"].collect(&:card) unless card_sets["no_bury"].nil?

    required_affiliations = ["required", "no_bury"]
    required_affiliations << "if_bury" if options[:bury]

    required_affiliations.each do |a|
      if card_sets[a]
        card_sets[a].each do |dc|
          cards << dc.card
        end
      end
    end
    
    if cards.count > player_count
      raise NotEnoughPlayersError, "Not enough players (minimum #{cards.count}). Provided #{player_count} #{options.inspect}"
    end
    
    if ( (count % 2) != (cards.count % 2) ) and card_sets["parity"]
    # if (count % 2) == 1 and card_sets["parity"].count
      cards << card_sets["parity"].sample.card
    end
    minimum_count = cards.count

    while count > cards.count and card_sets["filler"] do
      card_sets["filler"].each do |dc|
        cards << dc.card
      end
    end


    card_set = {}
    if options[:bury]
      buryable = cards.select{|c| ! no_burys.include? c }
      #p buryable.count
      buried = buryable.sample
      #p buried
      cards.delete_at cards.index(buried)

      card_set[:no_burys] = no_burys
      card_set[:buryable] = buryable
      card_set[:buried] = buried
      card_set[:cards] = cards 

        #debug
      # puts "#{player_count} #{options.inspect}"
      # card_set.each do |k,v| 
      #   puts "#{k}:"
      #   if k == :buried
      #     p v
      #   else
      #     v.each {|c| puts "\t#{c.title}"};
      #  end
      # end

    else
      card_set[:cards] = cards
    end


    if card_set[:cards].count != player_count
      message = if card_sets[:filler]
        "Deck does not support #{player_count} players, generated #{card_set[:cards].count} (#{minimum_count} + k * #{card_sets["filler"].count}). "
      else
        "Deck does not have filler, only supports #{minimum_count}" + ( card_sets[:parity] ? " - #{minimum_count + 1} " : " " ) + "players. "
      end
      message += "Provided #{player_count} #{options.inspect}"
      raise UnsupportedPlayerCountError, message
    end

    card_set
  end

  class DeckError < Exception
  end

  class NotEnoughPlayersError < DeckError
  end

  class UnsupportedPlayerCountError < DeckError
  end

  class UnableToBuryError < DeckError
  end

end
