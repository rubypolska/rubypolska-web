require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rubypolsce
  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Autoload
    config.autoload_paths << Rails.root.join('app', 'services')
    config.autoload_paths << Rails.root.join('app', 'models', 'form_objects')

    # Available locales
    I18n.available_locales = [:en, :pl, :ua]

    # Set default locale to something other than en:
    I18n.default_locale = :en

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
