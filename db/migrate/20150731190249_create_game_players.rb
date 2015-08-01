class CreateGamePlayers < ActiveRecord::Migration
  def change
    create_table :game_players do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :card_id
      t.string :location
      t.boolean :leader
      t.integer :voting_for_id

      t.timestamps null: false
    end
  end
end
