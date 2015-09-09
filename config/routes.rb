Rails.application.routes.draw do
  get "/auth/twitter/callback", to: "sessions#create"
  get "/auth/failure", to: "home#show"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "dashboard#show"
  root "home#show"
end
