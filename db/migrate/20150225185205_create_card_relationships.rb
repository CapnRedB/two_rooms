class CreateCardRelationships < ActiveRecord::Migration
  def change
    create_table :card_relationships do |t|
      t.integer :card_id
      t.integer :to_id
      t.string :description

      t.timestamps null: false
    end
  end
end
