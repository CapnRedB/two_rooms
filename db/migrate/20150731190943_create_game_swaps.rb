class CreateGameSwaps < ActiveRecord::Migration
  def change
    create_table :game_swaps do |t|
      t.integer :game_id
      t.integer :round_id
      t.integer :sequence
      t.integer :a_to_b_id
      t.integer :b_to_a_id

      t.timestamps null: false
    end
  end
end
