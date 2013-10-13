class PostVotesController < ApplicationController

  # POST /post_votes
  # POST /post_votes.json
  def create
    @vote = params[:vote]
    @post = Post.find(params[:post_id])
    current_user.vote_on_post(@vote, @post) if current_user

    respond_to do |format|
      format.js
    end
  end
end