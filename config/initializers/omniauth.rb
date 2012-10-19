Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV.fetch('OMNIAUTH_PROVIDER_KEY'), ENV.fetch('OMNIAUTH_PROVIDER_SECRET')
end
