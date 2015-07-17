class FixUserForEmber < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    remove_column :users, :nickname, :string
  end
end
