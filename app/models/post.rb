class Post < ActiveRecord::Base

  attr_accessible :link, :post_type, :text, :title, :user_id, :post_id, :status, :upvotes, :downvotes, :score, :spam_count, :slug, :topics_attributes

  belongs_to :user

  belongs_to :in_reply_to_post, foreign_key: "post_id", class_name: "Post"
  has_many :post_replies, foreign_key: "post_id", class_name: "Post"

  has_many :comments

  has_many :post_votes

  has_many :postviews

  has_many :spams

  has_many :post_and_topic_pairings
  has_many :topics, :through => :post_and_topic_pairings

  accepts_nested_attributes_for :topics

  has_many :interactions

  has_many :social_messages
  

  # SEARCH
  searchable do 
    text :title, :boost => 5
    text :text
    string :status
  end


  # VALIDATIONS

  validates_length_of :title, :maximum => 200, :allow_blank => false

  def format_url
    self.link = "http://#{self.link}" unless self.link[/^https?/]
  end

  def mine?(user_id)
    self.user_id == user_id
  end

  def user_vote(user)
    PostVote.find_by_post_id_and_user_id(self.id, user.id)
  end

  def draft?
    self.status == 'draft'
  end

  def link?
    self.post_type == 'link'
  end

  def text?
    self.post_type == 'text'
  end

  def live?
    self.status == 'live'
  end

  # SCOPES

  scope :live, -> { where('status = ?', 'live') }
  scope :draft, -> { where('status = ?', 'draft') }
  scope :deleted, -> { where('status = ?', 'deleted') }
  scope :infant, -> { where('status = ?', 'infant') }

  scope :top, ->(count) { order('score DESC').limit(count) }
  scope :highlighted_article, ->{ live.where("post_type = 'text' AND text IS NOT NULL").order('score DESC').limit(1) }
  scope :sorted_score, ->{ order('score DESC') }

  scope :most_upvotes, ->(count) { order('upvotes DESC').limit(count) }
  scope :today, -> { where('created_at > ?', 24.hours.ago) }

  scope :edited_recent, -> { order('updated_at DESC') }

  scope :created_recent, -> { order('created_at DESC') }


  # ATTRIBUTES

  def display_title
    (self.title && (self.title.length > 0)) ? self.title : 'Untitled'
  end

  # SLUG

  def update_slug
    if self.title
      string = self.title
      if string.length == 0
        string = 'untitled'
      end
      string = string.gsub(/[^0-9a-z ]/i, '').strip.squeeze(' ').downcase.gsub(' ', '-')
      self.update_attribute(:slug, string)
    end
  end

  #SCORE

  def current_score
    p = self.p_score
    t = (Time.now.to_i - self.created_at.to_time.to_i)/3600.0
    g = 1.8
    return (p-1)/((t+2)**g)
  end

  def vote_difference
    self.upvotes-self.downvotes
  end

  def p_score
    self.vote_difference + self.comments.count
  end

  def update_score
    self.update_attribute(:score, self.current_score)
    p_score > ENV['p_threshold'] ? self.delay.push_to_social_media : nil
  end


  # SOCIAL MEDIA

  def push_to_social_media
    text = "'#{self.display_title}'"
    if self.user.provider == 'twitter'
      text = "#{text} via @#{self.user.screen_name}"
    end
    text = "#{text} #{self.link_for_post}"

    m = SocialMessage.first_or_initialize_by_post_id_and_message_type(self.id, 'post_share')
    if !m.id
      m.save!
      m.send_message
    end
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
    self.update_created_at
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

  def update_created_at
    self.update_attribute(:created_at, DateTime.now)
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
    self.post_type == 'link' ? self.link : "/posts/#{self.id}/#{self.slug}"
  end

  def formatted_link_for_post
    self.post_type == 'link' ? self.link : "http%3A%2F%2Fstadiumtimes.com%2Fposts%2F#{self.id}%2F#{self.slug}"
  end


  # LINK

  def first_topic_text
    if self.topics.count > 0
      self.topics.first.topic_name
    else
      "The Best Sports News"
    end
  end

  # INTERACTIONS

  def add_interactions
    #reply post author
    if self.live?
      Interaction.find_or_create_by_user_id_and_post_id(self.in_reply_to_post.user.id, self.id) if self.post_id
    end
  end

end
