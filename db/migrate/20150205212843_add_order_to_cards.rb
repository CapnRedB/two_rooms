class AddOrderToCards < ActiveRecord::Migration
  def change
    add_column :cards, :sort_order, :integer
  end
end
