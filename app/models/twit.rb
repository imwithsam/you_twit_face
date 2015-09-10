class Twit
  def initialize(user = nil)
    @service ||= TwitterService.new(user)
  end

  def twit_feed
    @service.home_timeline
  end
end
