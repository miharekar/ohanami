# AppSignal Ruby gem configuration
# Visit our documentation for a list of all available configuration options.
# https://docs.appsignal.com/ruby/configuration/options.html
Appsignal.configure do |config|
  config.activate_if_environment("development", "production")
  config.name = "Ohanami"
  config.push_api_key = Rails.application.credentials.appsignal.push_api_key
end
