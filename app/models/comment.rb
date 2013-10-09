class Comment < ActiveRecord::Base
  attr_accessible :comment_id, :comment_text, :post_id, :user_id

  belongs_to :post 

  belongs_to :user

  has_many :comment_votes

  belongs_to :in_reply_to_comment, foreign_key: "comment_id", class_name: "Comment"
  has_many :comment_replies, foreign_key: "comment_id", class_name: "Comment"

  
  #VALIDATIONS

  validates_length_of :comment_text, :minimum => 1, :maximum => 200, :allow_blank => false



  #VOTING

  def vote_for_user(vote, user_id)
    v = CommentVote.find_or_initialize_by_comment_id_and_user_id({:comment_id => self.id, :user_id => user_id})
    v.vote = vote
    v.save!
  end
  
end
