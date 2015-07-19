class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.boolean :bury

      t.timestamps null: false
    end
  end
end
