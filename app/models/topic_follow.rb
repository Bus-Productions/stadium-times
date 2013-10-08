class TopicFollow < ActiveRecord::Base
  
  attr_accessible :manual_follow, :topic_id, :user_id

  belongs_to :topic
  belongs_to :user

end
