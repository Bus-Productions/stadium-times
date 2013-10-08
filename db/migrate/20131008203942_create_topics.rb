class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic_name
      t.integer :user_id
      t.boolean :featured

      t.timestamps
    end
  end
end
