class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_featured_topics, :set_search_vars


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

  private
  def me?(user_id)
    if !current_user
      false
    else
      user_id == current_user.id
    end
  end
  helper_method :me?


  # POSTS

  private
  def popular_posts
    @popular_posts = Post.most_upvotes(16).live.today
  end
  helper_method :popular_posts


  # TOPICS 
  
  def set_featured_topics
    @browsing_topics = Topic.featured(4)
  end


  # SEARCH

  def set_search_vars
    @post_search = Post.search do
      fulltext params[:search]
      with(:status).equal_to("live")
    end

    @topic_search = Topic.search do 
      fulltext params[:search]
    end

    @results = @post_search.results + @topic_search.results
  end

  # LINKS

  def browse_link(location, topic, order)
    location == 'topics' ? "/topics/#{topic.id}?sort=#{order}" : "/?sort=#{order}"
  end
  helper_method :browse_link

end
