class AddDefaultToScoreOnBothPostAndCommentModels < ActiveRecord::Migration
  def change
    change_column :posts, :score, :float, :default => 0
    change_column :comments, :score, :float, :default => 0
  end
end
