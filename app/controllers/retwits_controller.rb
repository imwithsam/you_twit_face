class FavoritesController < ApplicationController
  def update
    if Twit.new(current_user).favorite_twit(favorite_params)
      flash[:success] = "Twit favorited!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Unable to favorite this Twit."
      redirect_to dashboard_path
    end
  end

  def favorite_params
    params.require(:id)
  end
end
