# config/initializers/sidekiq.rb

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0' }  # Use 'redis' as the hostname
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/0' }  # Use 'redis' as the hostname
end
