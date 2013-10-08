class ChangeColumnNamesToAddIdInTopicPairings < ActiveRecord::Migration
  def up
    rename_column :topic_pairings, :parent, :parent_id
    rename_column :topic_pairings, :child, :child_id
  end

  def down
  end
end
