Twitter.configure do |config|
  config.consumer_key = ENV['OMNIAUTH_PROVIDER_KEY']
  config.consumer_secret = ENV['OMNIAUTH_PROVIDER_SECRET']
  config.oauth_token = ENV["TWITTER_OAUTH_TOKEN"]
  config.oauth_token_secret = ENV["TWITTER_OAUTH_TOKEN_SECRET"]
end