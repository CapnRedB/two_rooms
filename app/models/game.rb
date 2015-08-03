class Game < ActiveRecord::Base
  has_many :game_players
  has_many :game_swaps
  has_many :rounds, foreign_key: :game_type, primary_key: :game_type

  belongs_to :user
  belongs_to :deck

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
      Array.new(length){[*"a".."z", *"0".."9"].sample}.join
    end

    def add_self
      self.game_players << GamePlayer.new(player: self.user)
      save
    end
    
end
