class ChangeTextTypeOnPostsAndComments < ActiveRecord::Migration
  def up
    remove_column :posts, :text
    add_column :posts, :text, :text

    remove_column :comments, :comment_text
    add_column :comments, :comment_text, :text
  end

  def down
  end
end
