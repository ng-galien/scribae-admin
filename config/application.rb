require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdminApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1


    config.middleware.insert(0, Rack::ReverseProxy) do
      reverse_proxy_options force_ssl: false, replace_response_host: true
      reverse_proxy /^\/scribae(\/?.*)$/, 'http://127.0.0.1:4000/scribae/$1'
    end

    # Locales
    config.i18n.available_locales = %w(en fr)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.icons = config_for(:icons)
    config.scribae = config_for(:scribae)
    #config.active_job.queue_adapter = :inline
    #config.active_job.queue_adapter = :sucker_punch
    #config.log_level = :warn
    #config.active_record.logger = nil
    config.middleware.use I18n::JS::Middleware
    #config.middleware.insert_before Rack::Sendfile,ActionDispatch::DebugLocks
  end
  
end
