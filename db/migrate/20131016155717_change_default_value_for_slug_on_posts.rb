class ChangeDefaultValueForSlugOnPosts < ActiveRecord::Migration
  def up
    change_column :posts, :slug, :string, :default => 'untitled'
  end

  def down
  end
end
