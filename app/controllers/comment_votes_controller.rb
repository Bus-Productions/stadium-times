class CommentVotesController < ApplicationController

  # POST /comment_votes
  # POST /comment_votes.json
  def create

    @vote = params[:comment_vote][:vote]
    @comment = Comment.find(params[:comment_vote][:comment_id])
    current_user.vote_on_comment(@vote, @comment) if current_user

    respond_to do |format|
      format.js
      format.html { render :nothing => true, :status => 200 }
    end
    
  end

end
