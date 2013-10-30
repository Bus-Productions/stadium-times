class SocialMessage < ActiveRecord::Base
  attr_accessible :message_text, :message_type, :user_id, :post_id

  belongs_to :user

  belongs_to :post

  

  def send_message
    if message_type == 'twitter'
      self.send_tweet(self.message_text, "1390309333-ZOzONLBaLxhjdIS2vhfUIkPJUJwsg30CxEriewR", "3IjtOjqEasWsJ1YNR5N2zSJpDELVvSnYohrIcVBNui9KY")
    elsif message_type == 'post_share'
      self.send_tweet(self.message_text, "1390309333-ZOzONLBaLxhjdIS2vhfUIkPJUJwsg30CxEriewR", "3IjtOjqEasWsJ1YNR5N2zSJpDELVvSnYohrIcVBNui9KY")
    end
  end

  def send_tweet(text, token, secret)
    
    tweeter = Twitter::Client.new(
      :oauth_token => token,
      :oauth_token_secret => secret
    )

    tweeter.update(text)
    rescue => e
       #Either create an object where the error is log, or output it to what ever log you wish.
       p e
  end

  def format_message_text_twitter(front, quote, body, back, link)
    
    max_length = 110

    if front.length > 0
      front = "#{front} "
    end
    if back.length > 0
      back = "#{back} "
    end

    current_available = max_length - front.length - back.length

    if quote.length > 0
      quote = "\"#{quote.truncate(current_available)}\" "
    end

    current_available = current_available - quote.length - 1

    if body.length > 0
      body = "#{body.truncate(current_available)} "
    end

    self.message_text = "#{front}#{quote}#{body}#{back}#{link}"

    return self.message_text

  end

end
