class ChangeDefaultToDraftForStatusOnPostTable < ActiveRecord::Migration
  def up
    change_column :posts, :status, :string, :default => 'draft'
  end

  def down
  end
end
