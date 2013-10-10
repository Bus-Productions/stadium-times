class PostAndTopicPairingsController < ApplicationController
  # GET /post_and_topic_pairings
  # GET /post_and_topic_pairings.json
  def index
    @post_and_topic_pairings = PostAndTopicPairing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @post_and_topic_pairings }
    end
  end

  # GET /post_and_topic_pairings/1
  # GET /post_and_topic_pairings/1.json
  def show
    @post_and_topic_pairing = PostAndTopicPairing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post_and_topic_pairing }
    end
  end

  # GET /post_and_topic_pairings/new
  # GET /post_and_topic_pairings/new.json
  def new
    @post_and_topic_pairing = PostAndTopicPairing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post_and_topic_pairing }
    end
  end

  # GET /post_and_topic_pairings/1/edit
  def edit
    @post_and_topic_pairing = PostAndTopicPairing.find(params[:id])
  end

  # POST /post_and_topic_pairings
  # POST /post_and_topic_pairings.json
  def create
    @post_and_topic_pairing = PostAndTopicPairing.new(params[:post_and_topic_pairing])

    respond_to do |format|
      if @post_and_topic_pairing.save
        format.html { redirect_to @post_and_topic_pairing, notice: 'Post and topic pairing was successfully created.' }
        format.json { render json: @post_and_topic_pairing, status: :created, location: @post_and_topic_pairing }
      else
        format.html { render action: "new" }
        format.json { render json: @post_and_topic_pairing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /post_and_topic_pairings/1
  # PUT /post_and_topic_pairings/1.json
  def update
    @post_and_topic_pairing = PostAndTopicPairing.find(params[:id])

    respond_to do |format|
      if @post_and_topic_pairing.update_attributes(params[:post_and_topic_pairing])
        format.html { redirect_to @post_and_topic_pairing, notice: 'Post and topic pairing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post_and_topic_pairing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_and_topic_pairings/1
  # DELETE /post_and_topic_pairings/1.json
  def destroy
    @post_and_topic_pairing = PostAndTopicPairing.find(params[:id])
    @post_and_topic_pairing.destroy

    respond_to do |format|
      format.html { redirect_to post_and_topic_pairings_url }
      format.json { head :no_content }
    end
  end
end
