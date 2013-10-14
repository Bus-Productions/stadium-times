class Post < ActiveRecord::Base

  attr_accessible :link, :post_type, :text, :title, :user_id, :post_id, :status, :upvotes, :downvotes, :score, :spam_count

  belongs_to :user

  belongs_to :in_reply_to_post, foreign_key: "post_id", class_name: "Post"
  has_many :post_replies, foreign_key: "post_id", class_name: "Post"

  has_many :comments

  has_many :post_votes

  has_many :postviews

  has_many :spams

  has_many :post_and_topic_pairings
  has_many :topics, :through => :post_and_topic_pairings


  #VALIDATIONS

  validates_length_of :title, :minimum => 1, :maximum => 200, :allow_blank => false

  def mine?(user_id)
    self.user_id == user_id
  end


  # SCOPES

  scope :live, -> { where('status = ?', 'live') }
  scope :draft, -> { where('status = ?', 'draft') }
  scope :deleted, -> { where('status = ?', 'deleted') }

  scope :top, ->(count) { order('score DESC').limit(count) }
  scope :highlighted_article, ->{ where("text is NOT NULL").order('score DESC').limit(1) }

  scope :most_upvotes, ->(count) { order('upvotes DESC').limit(count) }
  scope :today, -> { where('created_at > ?', 24.hours.ago) }


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

  def upvote_count_text
    self.format_count_number(upvotes)
  end

  def downvote_count_text
    self.format_count_number(downvotes)
  end

  def format_count_number(number)
    if number < 1000
      number
    elsif number < 1000000
      n = number/1000
      "#{n}k"
    else
      n = number/1000000
      "#{n}M"
    end
  end

  def voted_on(user_id)
    PostVote.find_by_post_id_and_user_id(self.id, user_id)
  end

  #STATUS CHANGES

  def publish_post
    self.change_to_status('live')
  end

  def unpublish_post
    self.change_to_status('draft')
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
    self.save!
  end

  def marked_as_spam(user_id)
    Spam.find_by_post_id_and_user_id(self.id, user_id)
  end


  # LINK

  def link_for_post
    self.post_type == 'link' ? self.link : "/posts/#{self.id}"
  end


  # LINK

  def first_topic_text
    if self.topics.count > 0
      self.topics.first.topic_name
    else
      "The Best Sports News"
    end
  end

end
