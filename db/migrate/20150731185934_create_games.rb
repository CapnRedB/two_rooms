class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :deck_id
      t.string :game_type
      t.string :status
      t.text :outcome
      t.string :code

      t.timestamps null: false
    end
  end
end
