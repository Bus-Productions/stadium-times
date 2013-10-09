class ChangeDefaultSpamCountStatusOnCommentAndPostTables < ActiveRecord::Migration
  def up
    change_column :posts, :spam_count, :integer, :default => 0
    change_column :comments, :spam_count, :integer, :default => 0
  end

  def down
  end
end
