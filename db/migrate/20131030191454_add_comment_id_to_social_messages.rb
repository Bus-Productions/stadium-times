class AddCommentIdToSocialMessages < ActiveRecord::Migration
  def change
    add_column :social_messages, :comment_id, :integer
  end
end
