class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :text
    add_column :users, :location, :text
    add_column :users, :description, :text
    add_column :users, :website_url, :text
    add_column :users, :twitter_url, :text
    add_column :users, :token_secret, :text
  end
end
