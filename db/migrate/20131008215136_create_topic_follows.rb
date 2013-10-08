class CreateTopicFollows < ActiveRecord::Migration
  def change
    create_table :topic_follows do |t|
      t.integer :user_id
      t.integer :topic_id
      t.boolean :manual_follow

      t.timestamps
    end
  end
end
