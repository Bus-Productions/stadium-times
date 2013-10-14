class Comment < ActiveRecord::Base

  attr_accessible :comment_id, :comment_text, :post_id, :user_id, :upvotes, :downvotes, :score, :spam_count

  belongs_to :post 

  belongs_to :user

  has_many :comment_votes

  belongs_to :in_reply_to_comment, foreign_key: "comment_id", class_name: "Comment"
  has_many :comment_replies, foreign_key: "comment_id", class_name: "Comment"

  has_many :spams

  
  #VALIDATIONS

  validates_length_of :comment_text, :minimum => 1, :maximum => 200, :allow_blank => false

  def mine?(user_id)
    self.user_id == user_id
  end


  # SCOPES

  scope :top, ->(count) { order('score DESC').limit(count) }


  #SCORE

  def current_score
    p = self.vote_difference
    t = (Time.now.to_i - self.created_at.to_time.to_i)/3600.0
    g = 1.8
    return (p-1)/((t+2)**g)
  end

  def vote_difference
    self.upvotes-self.downvotes
  end


  #VOTING

  def add_vote(vote)
    vote == "up" ? self.update_attribute(:upvotes, self.upvotes+1) : self.update_attribute(:downvotes, self.downvotes+1)
  end


  # SPAM

  def spam?
    self.spam_count > 3
  end

  def increment_spam
    self.spam_count = self.spam_count+1
    self.save!
  end

  def marked_as_spam(user_id)
    Spam.find_by_comment_id_and_user_id(self.id, user_id)
  end
  
end