class AddQuantityToCard < ActiveRecord::Migration
  def change
    add_column :cards, :quantity, :integer, default: 1
  end
end
