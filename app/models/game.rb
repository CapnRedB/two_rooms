class Game < ActiveRecord::Base
  has_many :game_players
  has_many :game_swaps
  has_many :logs, class_name: "GameLog"
  has_many :rounds, foreign_key: :game_type, primary_key: :game_type

  belongs_to :user
  belongs_to :deck

  before_create :default_status
  before_create :ensure_code_and_seed
  after_create :add_owner_as_player

  # def to_param
  #   code
  # end


  def advance
    case status
    when "recruiting"
      start
    when "round_1", "round_2", "round_3", "round_4", "round_5"
      next_parlay
    when "parlay_1", "parlay_2", "parlay_3", "parlay_4", "parlay_5"
      next_round
    else
     raise UnableToAdvanceError, "Cannot advance from #{status}" if finished?   
    end      
  end

  def journal(event, command, description)
    log = self.logs.new(event: event, command: command, description: description)
    log.save
  end

  def seed
    @seed.to_i
  end


  Statuses = [ :recruiting, :starting, :transitioning, 
               :round_1, :round_2, :round_3, :round_4, :round_5, 
               :parlay_1, :parlay_2, :parlay_3, :parlay_4, :parlay_5, 
               :finished].freeze

  Statuses.each do |status|
    define_method(status.to_s + "?") do
      status == status
    end
  end

  def current_round
    number = game_swaps.max_by do |gs| 
      if gs.done?
        gs.round.number
      else
        1
      end
    end

    rounds.select {|r| r.number == number }
  end


  class GameError < Exception; end
  class UnableToAdvanceError < GameError; end

  private 

    def default_status
      self.status = :recruiting
    end
    
    def ensure_code_and_seed
      if self.code.blank?
        self.code = generate_code
      end
      if self.seed.nil?
        self.seed = Random.new_seed
      end
    end

    def generate_code
      length = Game.new_code_length
      loop do
        code = Game.make_code(length)
        break code unless Game.where(code: code).first
      end
    end
    
    def self.new_code_length
      [Math.log([Game.count,1].max).ceil, 4].max
    end
    
    def self.make_code(length)
      Array.new(length){[*"a".."z", *"0".."9"].reject{|l| "il10o8B3Evumnr".include? l}.sample}.join
    end
    
    def add_owner_as_player
      if user
        self.game_players << GamePlayer.new( player: user )
        journal "Adding Player", "add #{user.id}", "Adding owner, #{user.name}, to game."
        save
      end
    end

  def start(options = {})  # raises DeckErrors
    raise UnableToStartError, "Already Started" unless recruiting?

    card_set = deck.generate(game_players.count, bury: bury, seed: seed)
    cards = card_set[:cards]
    if bury
      journal "Burying a card", "bury #{card_set[:seed]}", "Card buried with seed #{card_set[:seed]}"
    end

    raise Deck::DeckError, "Deck size does not match player count" if cards.count != game_players.count

    rng = Random.new(seed)

    #shuffle the deck and deal it out
    game_players.zip cards.shuffle(random: rng) do |pair|
      pair[0].card = pair[1]
    end

    #shuffle the players and deal them into rooms
    game_players.shuffle(random: rng).each_with_index do |gp, idx|
      gp.location = (idx % 2 == 0) ? "Room A" : "Room B"
    end
    
    #in each room select a leader
    game_players.partition{|gp| gp.location == "Room A" }.each do |room|
      leader = room.sample(random: rng).leader = true
    end

    journal "Assigned players", "assign", "Cards, locations, and leaders were assigned with seed #{seed}"


    rounds.each do |round|
      swap = round.swap_for(game_players.count)
      game_swaps.count.times do |n|
        game << GameSwap.new(round: round, sequence: n)
      end
    end
    # generate all the swaps
    self.status = "round_1"
    journal "Start Game", "start", "Game started."

    self.save
  end

  def next_parlay

    journal "Parlay", "parlay", "Advanced to next parlay."
  end

  def next_round
  end

end
