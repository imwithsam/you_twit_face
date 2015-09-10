class User < ActiveRecord::Base
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider,
                                  uid: auth.uid)
    user.nickname = auth.info.nickname
    # email not provided by Twitter authentication
    user.provider = auth.provider
    user.token = auth.credentials.token
    user.uid = auth.uid
    user.image_url = auth.info.image
    user.name = auth.info.name
    user.location = auth.info.location
    user.description = auth.info.description
    user.website_url = auth.info.urls.website
    user.twitter_url = auth.info.urls.twitter
    user.token_secret = auth.credentials.secret
    user.save

    user
  end

  def twit_count
    twitter_stats ||= TwitterService.new(self).user
    twitter_stats.tweets_count
  end

  def following_count
    twitter_stats ||= TwitterService.new(self).user
    twitter_stats.friends_count
  end

  def followers_count
    twitter_stats ||= TwitterService.new(self).user
    twitter_stats.followers_count
  end
end
