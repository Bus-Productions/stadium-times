class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :vote

      t.timestamps
    end
  end
end
