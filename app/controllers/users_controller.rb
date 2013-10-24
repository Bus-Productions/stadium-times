class UsersController < ApplicationController

  def index
  end

  def show
    p "*"*50
    p params
    p "*"*50

    @user = User.find(params[:id])
    @comments = @user.comments.created_recent.paginate(:page => params[:page], :per_page => 7)

    @case = 'posts'
    if params[:display] == 'comments'
      @case = 'comments'
    elsif params[:display] == 'upvoted'
      @posts = @user.upvoted_posts
      @case = 'upvotes'
    elsif params[:display] == 'drafts'
      @posts = @user.posts.draft.edited_recent
      @case = 'drafts'
    else
      @posts = @user.posts.live.created_recent
    end

    respond_to do |format|
      format.js
      format.html
    end

  end

  def edit

    @user = User.find(params[:id])

    if @user.id != current_user.id
      redirect_to root_path
      return
    end

    respond_to do |format|
      format.js
      format.html
    end

  end
  
end