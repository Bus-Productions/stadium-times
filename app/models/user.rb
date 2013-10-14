class User < ActiveRecord::Base
  attr_accessible :email, :name, :oauth_expires_at, :oauth_token, :provider, :uid, :screen_name, :profile_picture, :bio

  has_many :posts

  has_many :comments

  has_many :post_votes

  has_many :upvoted_posts, :through => :post_votes, :source => :post

  has_many :comment_votes

  has_many :postviews

  has_many :topic_follows
  has_many :topics, :through => :topic_follows

  has_many :spams

  

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
      user.save!
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
    v ? v.update_attribute(:vote, vote) : PostVote.create({:vote => vote, :user_id => self.id, :post_id => post.id})
    v ? nil : post.add_vote(vote)
  end

  def vote_on_comment(vote, comment)
    v = self.comment_votes.find_by_comment_id(comment.id)
    v ? v.update_attribute(:vote, vote) : CommentVote.create({:vote => vote, :user_id => self.id, :comment_id => comment.id})
    v ? nil : comment.add_vote(vote)
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


end
