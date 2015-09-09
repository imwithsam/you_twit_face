class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(oauth_data)

    if user
      session[:user_id] = user.id
      flash[:success] = "You are now logged in to YouTwitFace. Twit away!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Unable to log in with your Twitter account."
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been logged out."
    redirect_to root_path
  end

  private

  def oauth_data
    request.env["omniauth.auth"]
  end
end
