require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShopifyRailsAppStarter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Load lib modules
    config.shopify = {
      domain: ENV.fetch("SHOPIFY_DOMAIN", nil)
    }
    config.shipstation = {
      api_key: ENV.fetch("SHIPSTATION_API_KEY", nil),
      api_secret: ENV.fetch("SHIPSTATION_API_SECRET", nil),
      shopify_store_id: 389717
    }

    config.autoload_paths << Rails.root.join("lib")
  end
end
