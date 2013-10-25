class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :comment_id
      t.integer :comment_vote_id
      t.integer :post_vote_id

      t.timestamps
    end
  end
end
