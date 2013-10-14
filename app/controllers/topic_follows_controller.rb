class TopicFollowsController < ApplicationController

  # POST /topic_follows
  # POST /topic_follows.json
  def create
    if current_user 
      @topic = Topic.find(params[:topic_id])
      current_user.follow_topic(@topic)
    end

    respond_to do |format|
      format.js
    end
  end

end
