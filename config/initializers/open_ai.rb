OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.open_ai.access_token!
end
