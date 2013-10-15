class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_featured_topics


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  private
  def current_user_or_redirect
    if !current_user
      redirect_to root_path
      return false
    else
      return true
    end
  end
  helper_method :current_user_or_redirect


  # POSTS

  private
  def popular_posts
    @popular_posts = Post.most_upvotes(16)
  end
  helper_method :popular_posts


  # TOPICS 
  
  def set_featured_topics
    @topics = Topic.featured(4)
  end

end
