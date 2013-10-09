class AddDownvoteToComments < ActiveRecord::Migration
  def change
    add_column :comments, :downvote, :integer, :default => 0
  end
end
