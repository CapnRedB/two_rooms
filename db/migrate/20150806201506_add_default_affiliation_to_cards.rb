class AddDefaultAffiliationToCards < ActiveRecord::Migration
  def change
    add_column :cards, :default_affiliation, :string, default: "required"
  end
end
