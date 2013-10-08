class TopicPairing < ActiveRecord::Base
  attr_accessible :child, :parent

  belongs_to :parent, :class_name => "Topic"
  belongs_to :child, :class_name => "Topic"
  
end
