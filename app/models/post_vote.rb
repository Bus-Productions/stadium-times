class PostVote < ActiveRecord::Base
  attr_accessible :post_id, :user_id, :vote

  belongs_to :user
  belongs_to :post

  default_scope where(:vote => 'up')

end
