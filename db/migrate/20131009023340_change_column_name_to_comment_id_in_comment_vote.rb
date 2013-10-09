class ChangeColumnNameToCommentIdInCommentVote < ActiveRecord::Migration
  def up
    rename_column :comment_votes, :post_id, :comment_id
  end

  def down
  end
end
