require "rails_helper"

RSpec.feature "ReTwit Twit", type: :feature do
  before do
    # Short circuit OmniAuth requests to use a mock authentication hash
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => "twitter",
      :uid => "123456",
      :info => {
        :nickname => "imwithsam",
        :name => "Samson Brock",
        :location => "Denver, CO",
        :image => "https://pbs.twimg.com/profile_images/606479431251550208/uYn3hNom.jpg",
        :description => "Turing School of Software & Design Student.",
        :urls => {
          :Website => "http://badmotivator.io/",
          :Twitter => "https://twitter.com/imwithsam"
        }
      },
      :credentials => {
        :token => ENV["twitter_token"],
        :secret => ENV["twitter_token_secret"]
      }
    })

    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:twitter]
  end

  scenario "User reTwits a Twit" do
    VCR.use_cassette("user_retwits_a_twit") do
      visit root_path
      click_link "Login"
      within(first(".panel-footer")) do
        find(".twit-retwit").click
      end

      within(".alert-success") do
        expect(page).to have_content("Twit retwitted!")
      end
    end
  end
end
