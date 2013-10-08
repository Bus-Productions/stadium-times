class Post < ActiveRecord::Base

  attr_accessible :link, :post_type, :text, :title, :user_id, :post_id

  belongs_to :user

  belongs_to :post 
  has_many :posts

end
