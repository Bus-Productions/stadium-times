class Comment < ActiveRecord::Base
  attr_accessible :comment_id, :comment_text, :post_id, :user_id
end
