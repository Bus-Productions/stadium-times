class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index

    @body_class = 'home'
    @browsing = 'Popular Articles'

    @posts = Post.live
    @topics = Topic.all
    
    @highlighted_article = Post.highlighted_article.first

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def search
    respond_to do |format|
      format.js
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    @post = Post.find(params[:id])

    if @post.text? && @post.draft?
      redirect_to edit_post_path(@post)
      return
    end

    if current_user
      @post.add_postview_for_user(@current_user.id)
    else
      @post.add_postview_for_user(0)
    end


    @body_class = 'off-canvas'

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new

    current_user_or_redirect ? nil : return

    if params[:post_type] && (params[:post_type] == 'link')
      @post = Post.new({:user_id => @current_user.id, :post_type => 'link'})
    else
      r = params[:r] ? params[:r] : nil
      @post = Post.create({:user_id => @current_user.id, :post_type => 'text', :status => 'infant', :post_id => r})
      redirect_to edit_post_path(@post)
      return
    end

  end

  # GET /posts/1/edit
  def edit

    current_user_or_redirect ? nil : return

    @post = Post.find(params[:id])
    @all_topics = Topic.all

    if !@post.mine?(@current_user.id)
      redirect_to root_path
      return
    end

    if @post.link?
      redirect_to post_path(@post)
      return
    end

  end

  # POST /posts
  # POST /posts.json
  def create

    current_user_or_redirect ? nil : return

    @post = Post.new(params[:post])
    @post.user_id = @current_user.id

    if @post.link?
      @post.status = 'live'
      @post.link = "http://#{@post.link}" unless @post.link[/^https?/]
    end

    respond_to do |format|
      if @post.save
        @post.update_slug
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update

    current_user_or_redirect ? nil : return

    @post = Post.find(params[:id])

    if !@post.mine?(@current_user.id)
      redirect_to root_path
      return
    end

    if @post.status == 'infant'
      @post.status = 'draft'
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        if @post.text
          t = @post.text.gsub("\n", "")
          t = t.strip
          @post.text = t
          @post.save!
        end
        @post.update_slug
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  # POST /posts/1/publish
  # POST /posts/1/publish.json
  def publish
    current_user_or_redirect ? nil : return

    @post = Post.find(params[:id])
    
    if !@post.mine?(@current_user.id)
      redirect_to root_path
      return
    end
    
    @post.status = 'live'

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully published.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end


  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy

    current_user_or_redirect ? nil : return

    @post = Post.find(params[:id])

    if !@post.mine?(@current_user.id)
      redirect_to root_path
      return
    end

    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.json { head :no_content }
    end
  end
end
