class TwitsController < ApplicationController
  def create
    if twit_params[:message].length > 140
      flash[:danger] = "Unable to post your Twit. Twits can be no longer" \
        " than 140 characters long."
      redirect_to dashboard_path
    elsif Twit.new(current_user).post_twit(twit_params[:message])
      flash[:success] = "Twit posted!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Unable to post your Twit."
      redirect_to dashboard_path
    end
  end

  def twit_params
    params.require(:twit).permit(:message)
  end
end
