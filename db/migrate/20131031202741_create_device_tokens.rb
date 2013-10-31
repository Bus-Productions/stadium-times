class CreateDeviceTokens < ActiveRecord::Migration
  def change
    create_table :device_tokens do |t|
      t.string :ios_device_token
      t.string :android_device_token
      t.integer :user_id

      t.timestamps
    end
  end
end
