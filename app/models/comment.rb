class Comment < ActiveRecord::Base

  attr_accessible :comment_id, :comment_text, :post_id, :user_id, :upvotes, :downvotes, :score, :spam_count

  belongs_to :post 

  belongs_to :user

  has_many :comment_votes

  belongs_to :in_reply_to_comment, foreign_key: "comment_id", class_name: "Comment"
  has_many :comment_replies, foreign_key: "comment_id", class_name: "Comment"

  has_many :spams

  has_many :interactions

  has_many :social_messages

  
  #VALIDATIONS

  validates_length_of :comment_text, :minimum => 1, :maximum => 200, :allow_blank => false

  def mine?(user_id)
    self.user_id == user_id
  end


  # SCOPES

  scope :top, ->(count) { order('score DESC').limit(count) }
  scope :created_recent, -> { order('created_at DESC') }


  #SCORE

  def current_score
    p = self.vote_difference
    t = (Time.now.to_i - self.created_at.to_time.to_i)/3600.0
    g = 1.15
    return (p-1)/((t+2)**g)
  end

  def vote_difference
    self.upvotes-self.downvotes
  end

  def update_score
    self.update_attribute(:score, self.current_score)
  end


  # LINK

  def link_for_comment
    "http://www.stadiumtimes.com/comments/#{self.id}"
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

  def voted_on(user)
    if !user
      return false
    else 
      CommentVote.find_by_comment_id_and_user_id(self.id, user.id)
    end
  end

  # INTERACTIONS

  def add_interactions
    #post author
    Interaction.find_or_create_by_user_id_and_comment_id(self.post.user.id, self.id)
    #in_reply author (if exists)
    Interaction.find_or_create_by_user_id_and_comment_id(self.in_reply_to_comment.user.id, self.id) if self.comment_id
    #send social media interactions
    self.delay.push_to_social_media
  end

  def push_to_social_media
    if !self.user.muted? && self.user.provider == 'twitter' && self.post.user.provider == 'twitter' && self.user.id != self.post.user.id
      
      m = SocialMessage.find_or_initialize_by_comment_id_and_user_id_and_message_type(self.id, self.user.id, 'comment_conversation')
      if !m.id
        m.format_message_text_twitter((in_reply_to_comment ? "@#{self.in_reply_to_comment.user.screen_name}" : "@#{self.post.user.screen_name}"), self.comment_text, "", "@StadiumTimes", self.link_for_comment)
        m.save!
        m.send_message
      end

    end
  end

  
end