class User < ActiveRecord::Base
  attr_accessible :email, :name, :oauth_expires_at, :oauth_token, :provider, :uid, :screen_name

  has_many :posts

  has_many :comments

  has_many :post_votes

  has_many :comment_votes

  has_many :postviews

  has_many :topic_follows
  has_many :topics, :through => :topic_follows


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.screen_name = auth.info.nickname
      if user.provider == 'facebook'
        user.email = auth.info.email.downcase
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      elsif user.provider == 'twitter'
      end
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end


  def vanity_url
    if self.provider == 'twitter'
      "http://twitter.com/#{self.screen_name}"
    elsif self.provider == 'facebook'
      "http://facebook.com/#{self.screen_name}"
    end
  end

end
