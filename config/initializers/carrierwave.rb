require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'ap-northeast-1',
    }
    config.fog_directory  = 'stamp-bon-voyage'
    config.fog_public     = false # オブジェクトへのすべてのアクセスをプライベートにします
    config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # オプション
  else
    config.storage = :file
    config.enable_processing = false if Rails.env.test?
  end
end
