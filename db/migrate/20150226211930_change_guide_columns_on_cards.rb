class ChangeGuideColumnsOnCards < ActiveRecord::Migration
  def change
    remove_column :cards, :allies
    remove_column :cards, :enemies
    remove_column :cards, :required
    remove_column :cards, :recommended

    add_column :cards, :required_text, :text
  end
end
