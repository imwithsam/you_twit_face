class TwitterService
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["twitter_api_key"]
      config.consumer_secret = ENV["twitter_secret_key"]
      config.access_token = current_user.token if current_user
      config.access_token_secret = current_user.token_secret if current_user
    end
  end
end
