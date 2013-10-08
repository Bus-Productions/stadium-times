class Topic < ActiveRecord::Base
  
  attr_accessible :featured, :topic_name, :user_id

  has_many :topic_pairings
  has_many :parents, :through => :topic_pairings, :class_name => "Topic"
  has_many :children, :through => :topic_pairings, :class_name => "Topic"

end
