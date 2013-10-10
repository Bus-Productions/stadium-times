class CreatePostAndTopicPairings < ActiveRecord::Migration
  def change
    create_table :post_and_topic_pairings do |t|
      t.integer :post_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
