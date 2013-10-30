class SocialMessage < ActiveRecord::Base
  attr_accessible :message_text, :message_type, :user_id, :post_id

  belongs_to :user

  belongs_to :post

  

  def send_message
    if message_type == 'twitter'
      self.send_tweet(self.message_text)
    elsif message_type == 'post_share'
      self.send_tweet(self.message_text)
    end
  end

  def send_tweet(text)
    Twitter.update(text)
    rescue => e
       #Either create an object where the error is log, or output it to what ever log you wish.
       p e
  end

end
