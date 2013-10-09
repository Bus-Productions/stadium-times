class AddUpvoteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :upvote, :integer, :default => 0
  end
end
