class ChangeColumnTypeForUserIdOnPost < ActiveRecord::Migration
  def up
    change_column :posts, :user_id, :integer
  end

  def down
  end
end
