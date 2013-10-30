class SocialMessage < ActiveRecord::Base
  attr_accessible :message_text, :message_type, :user_id

  belongs_to :user

  

  def send_message
    if message_type == 'twitter'
      self.send_tweet(self.message_text)
    end
  end

  def send_tweet(text)
    Twitter.update(text)
  end

end
