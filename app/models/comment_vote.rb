class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :user_id, :vote

  belongs_to :user
  belongs_to :comment

  has_many :interactions


  # INTERACTIONS

  def add_interactions
    #comment author
    Interaction.find_or_create_by_user_id_and_comment_vote_id(self.comment.user.id, self.id)
  end
  
end
