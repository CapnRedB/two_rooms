class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.string :subtitle
      t.text :short_desc
      t.text :long_desc
      t.string :color
      t.string :faction
      t.text :strategy
      t.string :url

      t.timestamps null: false
    end
  end
end
