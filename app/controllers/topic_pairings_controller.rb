class TopicPairingsController < ApplicationController
  # GET /topic_pairings
  # GET /topic_pairings.json
  def index
    @topic_pairings = TopicPairing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topic_pairings }
    end
  end

  # GET /topic_pairings/1
  # GET /topic_pairings/1.json
  def show
    @topic_pairing = TopicPairing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic_pairing }
    end
  end

  # GET /topic_pairings/new
  # GET /topic_pairings/new.json
  def new
    @topic_pairing = TopicPairing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic_pairing }
    end
  end

  # GET /topic_pairings/1/edit
  def edit
    @topic_pairing = TopicPairing.find(params[:id])
  end

  # POST /topic_pairings
  # POST /topic_pairings.json
  def create
    @topic_pairing = TopicPairing.new(params[:topic_pairing])

    respond_to do |format|
      if @topic_pairing.save
        format.html { redirect_to @topic_pairing, notice: 'Topic pairing was successfully created.' }
        format.json { render json: @topic_pairing, status: :created, location: @topic_pairing }
      else
        format.html { render action: "new" }
        format.json { render json: @topic_pairing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topic_pairings/1
  # PUT /topic_pairings/1.json
  def update
    @topic_pairing = TopicPairing.find(params[:id])

    respond_to do |format|
      if @topic_pairing.update_attributes(params[:topic_pairing])
        format.html { redirect_to @topic_pairing, notice: 'Topic pairing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic_pairing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topic_pairings/1
  # DELETE /topic_pairings/1.json
  def destroy
    @topic_pairing = TopicPairing.find(params[:id])
    @topic_pairing.destroy

    respond_to do |format|
      format.html { redirect_to topic_pairings_url }
      format.json { head :no_content }
    end
  end
end
