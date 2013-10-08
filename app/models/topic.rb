class Topic < ActiveRecord::Base

  attr_accessible :featured, :topic_name, :user_id

  has_many :topic_pairings, foreign_key: "parent_id"
  has_many :children, :through => :topic_pairings, :source => "child"

  has_many :reverse_topic_pairings, foreign_key: "child_id", class_name: "TopicPairing"
  has_many :parents, :through => :reverse_topic_pairings, :source => "parent"

end
