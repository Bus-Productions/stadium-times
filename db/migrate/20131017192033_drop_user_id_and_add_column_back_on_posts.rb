class DropUserIdAndAddColumnBackOnPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :user_id
    add_column :posts, :user_id, :integer
  end

  def down
  end
end
