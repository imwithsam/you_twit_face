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

  def update(twit_id = nil, message)
    if twit_id
      result = client.update(message, in_reply_to_status_id: twit_id)
    else
      result = client.update(message)
    end
  end

  def retweet(twits)
    begin
      result = client.retweet(twits)
    rescue
      return false
    end

    result
  end
end
