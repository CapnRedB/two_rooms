class CreateGameLogs < ActiveRecord::Migration
  def change
    create_table :game_logs do |t|
      t.integer :game_id
      t.string :event
      t.string :command
      t.text :description

      t.timestamps null: false
    end
  end
end
