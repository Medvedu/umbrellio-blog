require_relative 'boot'

%w(
  action_controller/railtie
  active_model/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  sprockets/railtie
).each { |railtie| require railtie }

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Umbrellio
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Load into ENV variables before initializers been load
    environment_file = File.join(Rails.root, 'config', '.env.' + Rails.env)
    if File.exists?(environment_file)
      YAML.load(File.open(environment_file)).each do |key, value|
        ENV[key.to_s] = value
      end
    end

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
