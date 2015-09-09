require "rails_helper"

RSpec.feature "User cannot log in with invalid Twitter credentials", type: :feature do
  before do
    # Short circuit OmniAuth requests to use a mock failure
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials

    Rails.application.env_config["omniauth.auth"] =
      OmniAuth.config.mock_auth[:twitter]
  end

  scenario "User tries to log in by clicking Login with Twitter link" do
    pending "Unsure how to display a flash alert upon auth failure"
    visit root_path
    click_link "Login"

    within(".alert-danger") do
      expect(page).to have_content("Unable to log in with your Twitter account.")
    end
  end
end
