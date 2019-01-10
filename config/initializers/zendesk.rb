require 'zendesk_api'
ZENDESK_SHARED_SECRET = 'hQPHYq9Ust8yaJrNpA16LfDMzKnQ4jX2ij5F4TH2pVhmZjRv'
ZENDESK_SUBDOMAIN = 'tenderscoutsupport'
$client = ZendeskAPI::Client.new do |config|
  # Mandatory:

  config.url = 'https://tenderscoutsupport.zendesk.com/api/v2' # e.g. https://mydesk.zendesk.com/api/v2

  # Basic / Token Authentication
  config.username = 'grace@tenderscout.com'


  config.password = 'Tenderscout1'



  # Optional:

  # Retry uses middleware to notify the user
  # when hitting the rate limit, sleep automatically,
  # then retry the request.
  config.retry = true

  # Logger prints to STDERR by default, to e.g. print to stdout:
  require 'logger'
  config.logger = Logger.new(STDOUT)

  # Changes Faraday adapter
  # config.adapter = :patron

  # Merged with the default client options hash
  # config.client_options = { :ssl => false }

  # When getting the error 'hostname does not match the server certificate'
  # use the API at https://yoursubdomain.zendesk.com/api/v2
end