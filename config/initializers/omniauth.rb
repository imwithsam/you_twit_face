Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO: Move API key and secret to Figaro
  provider :twitter, "BF7HtiuXawSxYyorxV1GGGMP4",
                     "oul5WgwuMbYs8zlVs1wOoO1Ol6lWl8MTg3jHbIVeqRZrFpnEJG"
end
