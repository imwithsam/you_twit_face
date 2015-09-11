Rails.application.routes.draw do
  get "/auth/twitter/callback", to: "sessions#create"
  get "/auth/failure", to: "home#show"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "dashboard#show"
  root "home#show"

  # TODO: Add a destroy route if we want to be able to unfavorite a Twit.
  resources :favorites, only: [:update]
  resources :twits, only: [:create]
  resources :retwit, only: [:update]
end
