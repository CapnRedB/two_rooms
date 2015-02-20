class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :game_type
      t.integer :number
      t.integer :duration

      t.timestamps null: false
    end
  end
end
