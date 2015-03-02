class AddGuideColumnsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :allies, :text
    add_column :cards, :enemies, :text
    add_column :cards, :required, :text
    add_column :cards, :recommended, :text  
  end
end
