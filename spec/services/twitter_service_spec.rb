require "rails_helper"

RSpec.describe "TwitterService" do
  let(:user) do
    User.new(
      nickname:     "imwithsam",
      provider:     "twitter",
      token:        ENV["twitter_token"],
      uid:          "12345",
      image_url:    "https://pbs.twimg.com/profile_images/606479431251550208/uYn3hNom.jpg",
      name:         "Samson Brock",
      location:     "Denver, CO",
      description:  "Turing School student",
      website_url:  "http://badmotivator.io/",
      twitter_url:  "http://twitter.com/imwithsam",
      token_secret: ENV["twitter_token_secret"]
    )
  end

  let(:service) { TwitterService.new(user) }

  it "returns user stats" do
    VCR.use_cassette("twitter_service_spec#user") do
      stats = service.user

      assert_equal "Samson Brock", stats.name
      assert_equal "imwithsam", stats.screen_name
      assert_equal "http://badmotivator.io/", stats.website.to_s
      assert_equal "Denver, CO", stats.location
      assert_equal "https://twitter.com/imwithsam", stats.uri.to_s
    end
  end

  it "returns home timeline" do
    VCR.use_cassette("twitter_service_spec#home_timeline") do
      timeline = service.home_timeline

      assert_equal 10, timeline.count
      assert_equal Array, timeline.class
    end
  end
end
