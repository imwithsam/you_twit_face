class TwitterService
  attr_reader :client

  def initialize(user = nil)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["twitter_api_key"]
      config.consumer_secret = ENV["twitter_secret_key"]
      config.access_token = user.token if user
      config.access_token_secret = user.token_secret if user
    end
  end

  def user
    client.user(skip_status: true)
  end

  def home_timeline
    client.home_timeline(count: 10)
  end

  def favorite(twits)
    client.favorite(twits)
  end

  def update(message)
    client.update(message)
  end
end
