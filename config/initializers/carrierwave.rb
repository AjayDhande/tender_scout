CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAJUZB7CT7XS7KXOKQ',
      aws_secret_access_key: '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',
      host:                  's3.amazonaws.com',
      endpoint:              'https://s3.amazonaws.com'
  }
  config.fog_directory  = 'bc-tenderscout-storage-stage'
  config.fog_public     = false
end
