class CreateSpams < ActiveRecord::Migration
  def change
    create_table :spams do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
