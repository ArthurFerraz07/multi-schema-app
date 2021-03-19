require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MultiSchemaApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    def database_schemas
      query = 'SELECT schema_name FROM information_schema.schemata;'
      ActiveRecord::Base.connection.execute(query).values.flatten - default_schemas
    end

    def default_schemas
      %w[pg_toast pg_temp_1 pg_toast_temp_1 pg_catalog public information_schema]
    end
  end
end
