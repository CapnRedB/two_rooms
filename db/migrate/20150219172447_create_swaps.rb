class CreateSwaps < ActiveRecord::Migration
  def change
    create_table :swaps do |t|
      t.integer :round_id
      t.integer :player_min
      t.integer :player_max
      t.integer :count

      t.timestamps null: false
    end
  end
end
