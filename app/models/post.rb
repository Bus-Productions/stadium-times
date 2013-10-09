class Post < ActiveRecord::Base

  attr_accessible :link, :post_type, :text, :title, :user_id, :post_id

  belongs_to :user

  belongs_to :in_reply_to_post, foreign_key: "post_id", class_name: "Post"
  has_many :post_replies, foreign_key: "post_id", class_name: "Post"

  has_many :comments

  has_many :post_votes

  has_many :postviews



  def add_postview_for_user(user_id)
    Postview.create({:user_id => user_id, :post_id => self.id})
  end

end
