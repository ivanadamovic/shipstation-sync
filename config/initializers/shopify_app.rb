ShopifyApp.configure do |config|
  config.application_name = ENV["SHOPIFY_APP_NAME"]
  config.api_key = ENV.fetch("SHOPIFY_API_KEY", "").presence || raise("Missing SHOPIFY_API_KEY")
  config.secret = ENV.fetch("SHOPIFY_API_SECRET", "").presence || raise("Missing SHOPIFY_API_SECRET")
  config.old_secret = ""
  config.scope = ENV["SHOPIFY_APP_SCOPES"]
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = ENV["SHOPIFY_API_VERSION"]
  config.shop_session_repository = "Shop"
  config.allow_jwt_authentication = true
  config.allow_cookie_authentication = false
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known
