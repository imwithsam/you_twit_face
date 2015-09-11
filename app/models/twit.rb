class Twit
  attr_reader :service

  def initialize(user = nil)
    @service ||= TwitterService.new(user)
  end

  def twit_feed
    service.home_timeline
  end

  def favorite_twit(twits)
    service.favorite(twits)
  end

  def post_twit(message)
    service.update(message)
  end

  def retwit_twit(twits)
    service.retweet(twits)
  end
end
