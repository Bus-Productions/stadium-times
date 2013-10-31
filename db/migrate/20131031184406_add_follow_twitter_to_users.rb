class AddFollowTwitterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :follow_twitter, :boolean
  end
end
