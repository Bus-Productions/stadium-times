class CommentsController < ApplicationController

  # GET /comments/1
  # GET /comments/1.json
  def show
    @this_comment = Comment.find(params[:id])
    @title = "Comment for #{@this_comment.post.display_title}"
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
      format.js
    end
  end

  # POST /comments
  # POST /comments.json
  def create

    current_user_or_redirect ? nil : return

    @comment = @current_user.comment_on_post(params[:comment])

    respond_to do |format|
      if @comment.save
        @comment.delay.add_interactions
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
        @saved_comment = @comment
        @comment = Comment.new
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

end
