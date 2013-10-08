class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_type
      t.string :user_id
      t.string :title
      t.string :text
      t.string :link

      t.timestamps
    end
  end
end
