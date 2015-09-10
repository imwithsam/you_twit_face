require "rails_helper"

RSpec.feature "User can log in with Twitter", type: :feature do
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
        :token => "abc123",
        :secret => "def456"
      }
    })

    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:twitter]
  end

  scenario "User logs in by clicking Login link" do
    visit root_path
    click_link "Login"

    within(".alert-success") do
      expect(page).to have_content("You are now logged in to YouTwitFace. Twit away!")
    end
    expect(page).to have_xpath("//img[@src=\"https://pbs.twimg.com/profile_images/606479431251550208/uYn3hNom.jpg\"]")
    expect(page).to have_content("@imwithsam")
  end

  scenario "User logs in with Twitter, logs out, then back in" do
    visit root_path
    click_link "Login"
    click_link "Logout"
    click_link "Login"

    within(".alert-success") do
      expect(page).to have_content("You are now logged in to YouTwitFace. Twit away!")
    end
    expect(page).to have_xpath("//img[@src=\"https://pbs.twimg.com/profile_images/606479431251550208/uYn3hNom.jpg\"]")
    expect(page).to have_content("@imwithsam")
  end
end
