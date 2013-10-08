class Comment < ActiveRecord::Base
  attr_accessible :comment_id, :comment_text, :post_id, :user_id

  belongs_to :post 

  belongs_to :user

  belongs_to :in_reply_to_comment, foreign_key: "comment_id", class_name: "Comment"
  has_many :comment_replies, foreign_key: "comment_id", class_name: "Comment"
  
end
