class AddDownvoteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :downvote, :integer, :default => 0
  end
end
