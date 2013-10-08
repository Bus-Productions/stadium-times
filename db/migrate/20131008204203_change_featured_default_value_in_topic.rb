class ChangeFeaturedDefaultValueInTopic < ActiveRecord::Migration
  def up
    change_column :topics, :featured, :boolean, :default => false
  end

  def down
  end
end
