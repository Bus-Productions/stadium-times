class TopicPairing < ActiveRecord::Base

  attr_accessible :child_id, :parent_id

  belongs_to :topic, :foreign_key => 'child_id'
  belongs_to :topic, :foreign_key => 'parent_id'

end
