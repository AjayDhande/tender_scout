PostmarkMailer.configure do |config|
  config.api_key = Rails.application.secrets.postmark_api_token
  config.default_delivery_queue = :mailers
end