class User < ActiveRecord::Base
  attr_accessible :email, :name, :oauth_expires_at, :oauth_token, :oauth_secret, :provider, :uid, :screen_name, :profile_picture, :bio, :follow_twitter

  has_many :posts

  has_many :comments

  has_many :post_votes

  has_many :upvoted_posts, :through => :post_votes, :source => :post

  has_many :comment_votes

  has_many :postviews

  has_many :topic_follows
  has_many :topics, :through => :topic_follows

  has_many :spams

  has_many :interactions

  has_many :social_messages

  has_many :device_tokens

  
  # VALIDATIONS

  before_validation :strip_white_space

  validate :check_email, :on => :update

  def strip_white_space
    if self.email
      self.email.strip!
    end
  end

  def check_email
    regex = /^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/
    if email.nil? || regex.match(email).nil?
      return false
    end
    return true
  end


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      p auth
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.screen_name = auth.info.nickname
      user.profile_picture = user.fix_profile_picture_string(auth.info.image)
      if user.provider == 'facebook'
        user.email = auth.info.email.downcase
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.bio = auth.info.bio
      elsif user.provider == 'twitter'
        user.bio = auth.info.description
      end
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      if !user.id
        user.save!
        user.delay.add_to_overall_mailing_list
        user.delay.send_welcome_social_message
      else
        user.save!
      end
    end
  end

  def from_mobile(params)
    self.oauth_token = params[:oauth_token]
    self.oauth_secret = params[:oauth_token_secret]
    info = self.lookup_twitter_user(params[:screen_name])

    if info
      p info
      self.provider = 'twitter'
      self.uid = info.id
      self.name = info.name
      self.screen_name = info.screen_name
      self.profile_picture = self.fix_profile_picture_string(info.profile_image_url)
      self.bio = info.description

      if !self.id
        self.save!
        self.delay.add_to_overall_mailing_list
        self.delay.send_welcome_social_message
      else
        self.save!
      end

    end
  end

  # USER INFO

  def vanity_username
    if self.provider == 'twitter'
      "@#{self.screen_name}"
    elsif self.provider == 'facebook'
      "#{self.screen_name}"
    end
  end

  def vanity_url
    if self.provider == 'twitter'
      "http://twitter.com/#{self.screen_name}"
    elsif self.provider == 'facebook'
      "http://facebook.com/#{self.screen_name}"
    end
  end

  def fix_profile_picture_string(string)
    if self.provider == 'twitter'
      return string.gsub("normal", "bigger")
    elsif self.provider == 'facebook'
      return string.gsub("type=square", "width=200&height=200")
    end
  end

  def muted?
    false
  end

  def verified?
    self.email
  end



  # TOPICS

  def follow_topic(topic) 
    self.topics.include?(topic) ? nil : self.topics << topic
  end

  def unfollow_topic(topic)  
    self.topics.include?(topic) ? self.topics.delete(topic) : nil
  end


  # COMMENTING

  def comment_on_post(params)
    post = Post.find_by_id(params[:post_id])
    Comment.new({:user_id => self.id, :post_id => post.id, :comment_id => params[:comment_id], :comment_text => params[:comment_text]})
  end


  # VOTING

  def vote_on_post(vote, post)
    v = self.post_votes.find_by_post_id(post.id)
    if v
      v.vote = vote
      v.save!
    else
      pv = PostVote.create({:vote => vote, :user_id => self.id, :post_id => post.id})
      post.add_vote(vote)
      post.delay.update_score
      pv.delay.add_interactions
    end
  end

  def vote_on_comment(vote, comment)
    v = self.comment_votes.find_by_comment_id(comment.id)
    if v
      v.update_attribute(:vote, vote)
    else
      cv = CommentVote.create({:vote => vote, :user_id => self.id, :comment_id => comment.id})
      comment.add_vote(vote)
      comment.delay.update_score
      cv.delay.add_interactions
    end
  end


  def upvoted_posts
    post_votes = PostVote.where("user_id = ? AND vote = ?", self.id, "up").includes(:post)
    post_votes.inject([]) { |result, pv| result << pv.post }
  end


  # SPAM

  def mark_post_as_spam(post_id)
    s = self.spams.find_by_post_id(post_id)
    if !s
      Spam.create({:user_id => self.id, :post_id => post_id})
      Post.find(post_id).increment_spam
    end
  end

  def mark_comment_as_spam(comment_id)
    s = self.spams.find_by_comment_id(comment_id)
    if !s
      Spam.create({:user_id => self.id, :comment_id => comment_id})
      Comment.find(comment_id).increment_spam
    end
  end


  # MAILING LISTS

  def add_to_overall_mailing_list
    gb = Gibbon::API.new("d11ed4383fba5209f0e706d912dbba6c-us7")
    gb.throws_exceptions = false
    gb.lists.subscribe({:id => '08ac9be67c', :email => {:email => self.email }, :merge_vars => {:FNAME => self.name, :LNAME => ''}, :double_optin => false})
  end

  # SOCIAL MESSAGES

  def send_welcome_social_message
    m = SocialMessage.new({:user_id => self.id, :message_type => self.provider})
    if m.message_type == 'twitter'
      m.message_text = "@#{self.screen_name} Welcome to the @StadiumTimes club! Let us know if you have any questions."
      m.save!
      m.send_message
    end
  end

  def follow_stadium_times_twitter
    tweeter = Twitter::Client.new(
      :oauth_token => self.oauth_token,
      :oauth_token_secret => self.oauth_secret
    )
    tweeter.follow('stadiumtimes')
    rescue => e
       #Either create an object where the error is log, or output it to what ever log you wish.
       p e
  end


  def lookup_twitter_user(sn)
    tweeter = Twitter::Client.new(
      :oauth_token => self.oauth_token,
      :oauth_token_secret => self.oauth_secret
    )
    tweeter.user(sn)
    rescue => e
       #Either create an object where the error is log, or output it to what ever log you wish.
       p e
  end
  

end
