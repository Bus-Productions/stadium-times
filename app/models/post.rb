class Post < ActiveRecord::Base

  attr_accessible :link, :post_type, :text, :title, :user_id, :post_id, :status

  belongs_to :user

  belongs_to :in_reply_to_post, foreign_key: "post_id", class_name: "Post"
  has_many :post_replies, foreign_key: "post_id", class_name: "Post"

  has_many :comments

  has_many :post_votes

  has_many :postviews


  #VALIDATIONS

  validates_length_of :title, :minimum => 1, :minimum => 200, :allow_blank => false



  #POSTVIEWS

  def add_postview_for_user(user_id)
    Postview.create({:user_id => user_id, :post_id => self.id})
  end


  #VOTING

  def vote_for_user(vote, user_id)
    v = PostVote.find_or_initialize_by_post_id_and_user_id({:post_id => self.id, :user_id => user_id})
    v.vote = vote
    v.save!
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
