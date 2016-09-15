Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['fb_key'], ENV['fb_secret']
end