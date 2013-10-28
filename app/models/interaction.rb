class Interaction < ActiveRecord::Base
  attr_accessible :comment_id, :comment_vote_id, :post_id, :post_vote_id, :user_id

  belongs_to :user 
  belongs_to :post 
  belongs_to :comment 
  belongs_to :post_vote 
  belongs_to :comment_vote


  # SCOPES

  scope :created_recent, -> { order('created_at DESC') }


  # METHODS
  
  def interaction_type
    if comment_id
      'comment'
    elsif comment_vote_id
      'comment_vote'
    elsif post_id
      'post'
    elsif post_vote_id
      'post_vote'
    end
  end

end
