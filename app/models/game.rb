class Game < ActiveRecord::Base
  has_many :game_players
  has_many :game_swaps
<<<<<<< HEAD
  has_many :rounds, foreign_key: :game_type, primary_key: :game_type
=======
>>>>>>> feature-game-um

  belongs_to :user
  belongs_to :deck

<<<<<<< HEAD
  before_create :default_status
  before_create :ensure_code
  after_create :add_self





  private 

    def default_status
      self.status = :recruiting
    end
    
    def ensure_code
      if self.code.blank?
        self.code = generate_code
      end
    end

=======
  before_create :ensure_code
  before_create :default_status
  after_create :add_owner_as_player

  # def to_param
  #   code
  # end

  def default_status
    self.status = :recruiting
  end
  
  def ensure_code
    if self.code.blank?
      self.code = generate_code
    end
  end

  def self.new_code_length
    [Math.log([Game.count,1].max).ceil, 4].max
  end

  private 

>>>>>>> feature-game-um
    def generate_code
      length = Game.new_code_length
      loop do
        code = Game.make_code(length)
        break code unless Game.where(code: code).first
      end
    end
<<<<<<< HEAD
    
    def self.new_code_length
      [Math.log([Game.count,1].max).ceil, 4].max
    end
    
    def self.make_code(length)
      Array.new(length){[*"a".."z", *"0".."9"].sample}.join
    end

    def add_self
      self.game_players << GamePlayer.new(player: self.user)
      save
    end
    
=======

    def self.make_code(length)
      Array.new(length){[*"a".."z", *"0".."9"].reject{|l| "il10o8B3Evumnr".include? l}.sample}.join
    end
    
    def add_owner_as_player
      if user
        self.game_players << GamePlayer.new( player: user )
        save
      end
    end
>>>>>>> feature-game-um
end
