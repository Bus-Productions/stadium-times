class AddUpvoteToComments < ActiveRecord::Migration
  def change
    add_column :comments, :upvote, :integer, :default => 0
  end
end
