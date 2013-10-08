class TopicFollowsController < ApplicationController
  # GET /topic_follows
  # GET /topic_follows.json
  def index
    @topic_follows = TopicFollow.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topic_follows }
    end
  end

  # GET /topic_follows/1
  # GET /topic_follows/1.json
  def show
    @topic_follow = TopicFollow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic_follow }
    end
  end

  # GET /topic_follows/new
  # GET /topic_follows/new.json
  def new
    @topic_follow = TopicFollow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic_follow }
    end
  end

  # GET /topic_follows/1/edit
  def edit
    @topic_follow = TopicFollow.find(params[:id])
  end

  # POST /topic_follows
  # POST /topic_follows.json
  def create
    @topic_follow = TopicFollow.new(params[:topic_follow])

    respond_to do |format|
      if @topic_follow.save
        format.html { redirect_to @topic_follow, notice: 'Topic follow was successfully created.' }
        format.json { render json: @topic_follow, status: :created, location: @topic_follow }
      else
        format.html { render action: "new" }
        format.json { render json: @topic_follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topic_follows/1
  # PUT /topic_follows/1.json
  def update
    @topic_follow = TopicFollow.find(params[:id])

    respond_to do |format|
      if @topic_follow.update_attributes(params[:topic_follow])
        format.html { redirect_to @topic_follow, notice: 'Topic follow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic_follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topic_follows/1
  # DELETE /topic_follows/1.json
  def destroy
    @topic_follow = TopicFollow.find(params[:id])
    @topic_follow.destroy

    respond_to do |format|
      format.html { redirect_to topic_follows_url }
      format.json { head :no_content }
    end
  end
end
