class PostviewsController < ApplicationController
  # GET /postviews
  # GET /postviews.json
  def index
    @postviews = Postview.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @postviews }
    end
  end

  # GET /postviews/1
  # GET /postviews/1.json
  def show
    @postview = Postview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @postview }
    end
  end

  # GET /postviews/new
  # GET /postviews/new.json
  def new
    @postview = Postview.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @postview }
    end
  end

  # GET /postviews/1/edit
  def edit
    @postview = Postview.find(params[:id])
  end

  # POST /postviews
  # POST /postviews.json
  def create
    @postview = Postview.new(params[:postview])

    respond_to do |format|
      if @postview.save
        format.html { redirect_to @postview, notice: 'Postview was successfully created.' }
        format.json { render json: @postview, status: :created, location: @postview }
      else
        format.html { render action: "new" }
        format.json { render json: @postview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /postviews/1
  # PUT /postviews/1.json
  def update
    @postview = Postview.find(params[:id])

    respond_to do |format|
      if @postview.update_attributes(params[:postview])
        format.html { redirect_to @postview, notice: 'Postview was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @postview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postviews/1
  # DELETE /postviews/1.json
  def destroy
    @postview = Postview.find(params[:id])
    @postview.destroy

    respond_to do |format|
      format.html { redirect_to postviews_url }
      format.json { head :no_content }
    end
  end
end
