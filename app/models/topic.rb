class Topic < ActiveRecord::Base

  attr_accessible :featured, :topic_name, :user_id

  has_many :topic_pairings, foreign_key: "parent_id"
  has_many :children, :through => :topic_pairings, :source => "child"

  has_many :reverse_topic_pairings, foreign_key: "child_id", class_name: "TopicPairing"
  has_many :parents, :through => :reverse_topic_pairings, :source => "parent"

  has_many :topic_follows
  has_many :users, :through => :topic_follows

  has_many :post_and_topic_pairings
  has_many :posts, :through => :post_and_topic_pairings


  # SCOPES 

  scope :featured, ->(count) { where("featured = ?", true).limit(count) }

  def followed_by(user_id)
    TopicFollow.find_by_topic_id_and_user_id(self.id, user_id)
  end

  def related_topics
    (self.children + self.parents).sample(10)
  end


  # SEARCH

  searchable do 
    text :topic_name, :boost => 3
  end

end
