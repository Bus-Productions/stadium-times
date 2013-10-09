class Spam < ActiveRecord::Base
  attr_accessible :comment_id, :post_id, :user_id

  belongs_to :user
  belongs_to :comment 
  belongs_to :post
  
end
