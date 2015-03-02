class AnotherChangeToCardsForGuide < ActiveRecord::Migration
  def change
    add_column :cards, :recommended_text, :text
  end
end
