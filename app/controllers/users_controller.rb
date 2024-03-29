class UsersController < ApplicationController

  def show

    @user = User.find(params[:id])
    @title = @user.name

    case_var = params[:display]

    if !me?(@user.id) && (case_var != 'posts' && case_var != 'comments' && case_var != 'upvotes')
      case_var = 'posts'
    end

    if case_var == 'posts'
      @posts = @user.posts.live.created_recent.paginate(:page => params[:page], :per_page => 7)
      @case = 'posts'
    elsif case_var == 'comments'
      @comments = @user.comments.created_recent.paginate(:page => params[:page], :per_page => 7)
      @case = 'comments'
    elsif case_var == 'upvotes'
      @posts = @user.upvoted_posts.paginate(:page => params[:page], :per_page => 7)
      @case = 'upvotes'
    elsif case_var == 'drafts'
      @posts = @user.posts.draft.edited_recent.paginate(:page => params[:page], :per_page => 7)
      @case = 'drafts'
    else
      @interactions = @user.interactions.created_recent.paginate(:page => params[:page], :per_page => 7)
      @case = 'interactions'
      @comment = Comment.new
    end

    respond_to do |format|
      format.js
      format.html
    end

  end

  def edit

    @user = User.find(params[:id])
    @title = @user.name

    if @user.id != current_user.id
      redirect_to root_path
      return
    end

    respond_to do |format|
      format.js
      format.html
    end

  end


  def update

    @user = User.find(params[:id])
    @title = @user.name

    if @user.id != unverified_user.id || params[:user][:email].length < 4
      redirect_to root_path
      return
    end

    @user.update_attributes(params[:user])

    @user.follow_twitter ? @user.delay.follow_stadium_times_twitter : nil
    @user.delay.add_to_overall_mailing_list

    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
      format.json { render json: @user }
    end

  end
  
end