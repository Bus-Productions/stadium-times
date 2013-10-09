class AddSpamColumnsToPostAndCommentTables < ActiveRecord::Migration
  def change
    add_column :posts, :spam_count, :integer
    add_column :comments, :spam_count, :integer
  end
end
