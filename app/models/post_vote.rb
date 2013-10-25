class PostVote < ActiveRecord::Base
  attr_accessible :post_id, :user_id, :vote

  belongs_to :user
  belongs_to :post

  has_many :interactions


  def add_interactions
    #comment author
    Interaction.find_or_create_by_user_id_and_post_id(self.post.user.id, self.post_id)
  end

end
