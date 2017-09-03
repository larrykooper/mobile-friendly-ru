require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MobileFriendlyRu
  # Rails::Application is responsible for executing all railties and
  # engines initializers. It also executes some bootstrap initializers.
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.autoload_paths << Rails.root.join('lib')

    config.assets.precompile += [left_arrow.svg]

    # Settings in config/environments/* take precedence
    #   over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
