class Post < ActiveRecord::Base

  attr_accessible :link, :post_type, :text, :title, :user_id, :post_id, :status, :upvotes, :downvotes, :score, :spam_count

  belongs_to :user

  belongs_to :in_reply_to_post, foreign_key: "post_id", class_name: "Post"
  has_many :post_replies, foreign_key: "post_id", class_name: "Post"

  has_many :comments

  has_many :post_votes

  has_many :postviews

  has_many :spams


  #VALIDATIONS

  validates_length_of :title, :minimum => 1, :maximum => 200, :allow_blank => false

  def mine?(user_id)
    self.user_id == user_id
  end


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


  #POSTVIEWS

  def add_postview_for_user(user_id)
    Postview.create({:user_id => user_id, :post_id => self.id})
  end


  #VOTING

  def add_vote(vote)
    vote == "up" ? self.update_attribute(:upvotes, self.upvotes+1) : self.update_attribute(:downvotes, self.downvotes+1)
  end

  #STATUS CHANGES

  def publish_post
    self.change_to_status('live')
  end

  def unpublish_post
    self.change_to_status('private')
  end

  def delete_post
    self.change_to_status('deleted')
  end

  def change_to_status(new_status)
    self.update_attribute(:status, new_status)
  end


  # SPAM

  def spam?
    self.spam_count > 3
  end

  def increment_spam
    self.spam_count = self.spam_count+1
  end

end
