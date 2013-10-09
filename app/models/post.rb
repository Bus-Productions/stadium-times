class Post < ActiveRecord::Base

  attr_accessible :link, :post_type, :text, :title, :user_id, :post_id, :status, :upvotes, :downvotes, :score

  belongs_to :user

  belongs_to :in_reply_to_post, foreign_key: "post_id", class_name: "Post"
  has_many :post_replies, foreign_key: "post_id", class_name: "Post"

  has_many :comments

  has_many :post_votes

  has_many :postviews


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

  def vote_for_user(vote, user_id)
    v = PostVote.find_or_initialize_by_post_id_and_user_id({:post_id => self.id, :user_id => user_id})
    if !v.id
      self.add_vote_to_self(vote)
    end
    v.vote = vote
    v.save!
  end

  def add_vote_to_self(vote)
    if vote == 'up'
      self.upvotes = self.upvotes+1
    elsif vote == 'down'
      self.downvotes = self.downvotes+1
    end
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

end
