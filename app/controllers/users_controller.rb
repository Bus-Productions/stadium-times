class UsersController < ApplicationController

  def index
  end

  def show

    @user = User.find(params[:id])

    params[:display] == 'comments' ? @comments = @user.comments : @posts = @user.posts

    respond_to do |format|
      format.js
      format.html
    end

  end

  def edit

    @user = User.find(params[:id])

    if @user.id != current_user.id
      redirect_to root_path
      return
    end

    respond_to do |format|
      format.js
      format.html
    end

  end
  
end