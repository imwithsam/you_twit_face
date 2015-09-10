class DashboardController < ApplicationController
  def show
    @twits = Twit.new(current_user).twit_feed
  end
end
