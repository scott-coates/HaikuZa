Rails.application.config.middleware.use OmniAuth::Builder do #TODO:why is this middleware?
  provider :twitter, ENV['OMNIAUTH_PROVIDER_KEY'], ENV['OMNIAUTH_PROVIDER_SECRET'] #TODO: write a test to validate these exist
end
