class TopicPairing < ActiveRecord::Base

  attr_accessible :child_id, :parent_id

  belongs_to :child, :class_name => 'Topic'
  belongs_to :parent, :class_name => 'Topic'

end
