class PostsController < ApplicationController

  # GET /posts
  # GET /posts.json
  def index

    @body_class = 'home'
    @browsing = 'Popular Articles'

    @posts = Post.live
    @highlighted_article = Post.highlighted_article.first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    @post = Post.find(params[:id])

    if current_user
      @post.add_postview_for_user(@current_user.id)
    else
      @post.add_postview_for_user(0)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new

    current_user_or_redirect ? nil : return

    @post = Post.create({:user_id => @current_user.id, :post_type => 'text', :status => 'infant'})

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit

    current_user_or_redirect ? nil : return

    @post = Post.find(params[:id])

    if !@post.mine?(@current_user.id)
      redirect_to root_path
      return
    end

  end

  # POST /posts
  # POST /posts.json
  def create

    current_user_or_redirect ? nil : return

    @post = Post.new(params[:post])
    @post.user_id = @current_user.id

    respond_to do |format|
      if @post.save
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
      @posts.status = 'draft'
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
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
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
