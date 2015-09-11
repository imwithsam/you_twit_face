class ReplyController < ApplicationController
  def create
    if reply_params[:message].length > 140
      flash[:danger] = "Unable to send your reply. Twits can be no longer" \
        " than 140 characters long."
      redirect_to dashboard_path
    elsif Twit.new(current_user).reply_to_twit(reply_params[:twit_id],
                                               reply_params[:message])
      flash[:success] = "Reply sent!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Unable to send your reply."
      redirect_to dashboard_path
    end
  end

  def reply_params
    params.require(:reply).permit(:twit_id, :message)
  end
end
