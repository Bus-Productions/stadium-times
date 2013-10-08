class CreateTopicPairings < ActiveRecord::Migration
  def change
    create_table :topic_pairings do |t|
      t.integer :parent
      t.integer :child

      t.timestamps
    end
  end
end
