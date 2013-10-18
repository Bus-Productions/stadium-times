class PostVotesController < ApplicationController

  # POST /post_votes
  # POST /post_votes.json
  def create
    p "*"*400
    @vote = params[:vote]
    @post = Post.find(params[:post_id])
    current_user.vote_on_post(@vote, @post) if current_user

    respond_to do |format|
      format.js
      format.html { render :nothing => true, :status => 200 }
    end
  end
end