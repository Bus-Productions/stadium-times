class AddPostIdToSocialMessages < ActiveRecord::Migration
  def change
    add_column :social_messages, :post_id, :integer
  end
end
