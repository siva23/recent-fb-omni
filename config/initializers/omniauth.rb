require "omniauth-facebook"

Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  provider :facebook, '1400904003543515', '70f3e610f373b4b237cae0295933bb43',
  :scope => 'email,user_birthday,read_stream'
end