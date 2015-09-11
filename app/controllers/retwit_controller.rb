class RetwitController < ApplicationController
  def update
    if Twit.new(current_user).retwit_twit(retwit_params)
      flash[:success] = "Twit retwitted!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Unable to retwit this Twit."
      redirect_to dashboard_path
    end
  end

  def retwit_params
    params.require(:id)
  end
end
