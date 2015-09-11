require "rails_helper"

RSpec.feature "Reply to a Twit", type: :feature do
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

  scenario "User replies to a Twit" do
    VCR.use_cassette("user_replies_to_a_twit") do
      visit root_path
      click_link "Login"
      within(first(".panel-footer")) do
        find(".twit-reply").click
      end
      within(".modal-content") do
        fill_in "reply[message]", with: "This is a test of the Twitter API system."
        find("button[type='submit']").click
      end

      within(".alert-success") do
        expect(page).to have_content("Reply sent!")
      end
    end
  end

  scenario "User tries to reply to a Twit with more than 140 characters" do
    VCR.use_cassette("user_replies_with_more_than_140_characters") do
      visit root_path
      click_link "Login"
      within(first(".panel-footer")) do
        find(".twit-reply").click
      end
      within(".modal-content") do
        fill_in "reply[message]",
          with: "This is a test of the Twitter API system. This tweet is" \
            " longer than 140 characters and should fail to be submitted." \
            " Length of 141 characters."
        find("button[type='submit']").click
      end

      within(".alert-danger") do
        expect(page).to have_content("Unable to send your reply. Twits can" \
          " be no longer than 140 characters long.")
      end
    end
  end
end
