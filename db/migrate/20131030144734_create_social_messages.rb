class CreateSocialMessages < ActiveRecord::Migration
  def change
    create_table :social_messages do |t|
      t.integer :user_id
      t.text :message_text
      t.string :message_type

      t.timestamps
    end
  end
end
