class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.verified?
      redirect_to root_url
      return
    else
      redirect_to verify_login_path({:verify => 'true'})
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def create_mobile
    user = User.find_or_initialize_by_uid_and_provider(params[:user_id], 'twitter')
    user.from_mobile(params[:user])
    respond_to do |format|
      format.json { render json: { user.as_json(:methods => :verified? ) } }
    end
  end
  
end