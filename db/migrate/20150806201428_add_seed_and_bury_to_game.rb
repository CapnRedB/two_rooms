class AddSeedAndBuryToGame < ActiveRecord::Migration
  def change
    add_column :games, :bury, :boolean
    add_column :games, :seed, :string
  end
end
