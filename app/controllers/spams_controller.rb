class SpamsController < ApplicationController

  # POST /spams
  # POST /spams.json
  def create
    if current_user 
      if params[:post_id] != "0"
        current_user.mark_post_as_spam(params[:post_id]) 
        @received_obj = Post.find(params[:post_id])
      else
        current_user.mark_comment_as_spam(params[:comment_id])
        @received_obj = Comment.find(params[:comment_id])
      end
    end

    respond_to do |format|
      format.js
    end
  end

end
