class ChangeColumnNamesForUpvotesAndDownvotesToPlurals < ActiveRecord::Migration
  def up
    rename_column :posts, :upvote, :upvotes
    rename_column :posts, :downvote, :downvotes
    rename_column :comments, :upvote, :upvotes
    rename_column :comments, :downvote, :downvotes
  end

  def down
  end
end
