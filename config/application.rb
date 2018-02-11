require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MundialApp
  class Application < Rails::Application
     # Initialize configuration defaults for originally generated Rails version.
     config.load_defaults 5.1
     config.time_zone = 'Warsaw'
     config.i18n.enforce_available_locales = false
     config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
     config.i18n.default_locale = :pl
     # Settings in config/environments/* take precedence over those specified here.
     # Application configuration should go into files in config/initializers
     # -- all .rb files in that directory are automatically loaded.
 
     config.eager_load_paths += %W["#{config.root}/lib/"]
     config.enable_dependency_loading = true
     config.autoload_paths += Dir["#{config.root}/lib/"]
 
     config.active_record.default_timezone = :local
     config.active_job.queue_adapter = :async
  end
end
